module Ellis
  class Tools
    class << self
      # Provides a detailed annotation of ActiveRecord models or Rails controllers. This method can output annotations
      # directly to the console, copy them to the clipboard, or append them to the relevant model or controller files.
      # It is designed to help developers quickly understand the structure and relationships of various components in
      # their application.
      #
      # Usage:
      #   load '/{path to file}/tools.rb'
      #   Ellis::Tools.annotate [Model], *options
      #
      # Example:
      #   Ellis::Tools.annotate User, to_file: true
      #
      # Options:
      #   :to_clipboard - (Boolean) Whether to copy the output to the clipboard. Default: true.
      #   :to_screen - (Boolean) Whether to display the output on the screen. Default: true.
      #   :to_file - (Boolean) Whether to append the output to the model's file. Default: false.
      #
      # @param target [Class] The ActiveRecord model or Rails controller to be annotated.
      # @param args [Hash] A hash of options to customize the behavior of the method.
      def annotate target, args = {}
        defaults = {
          to_clipboard: true,
          to_screen: true,
          to_file: false
        }
        options = defaults.merge args

        if !!(target.is_a?(Class) && target < ActiveRecord::Base)
          annotate_model target, options
        elsif !!(target.is_a?(Class) && target < ApplicationController)
          annotate_controller target, options
        else
          puts "Error: I don't know what you're trying to do."
        end
      end

      # Compares the execution times of two methods using the Ruby Benchmark module.
      # It executes each method a specified number of times and reports the execution time.
      #
      # @param old [Symbol, String] the name of the first method to benchmark.
      # @param new [Symbol, String, nil] the name of the second method to benchmark, optional.
      # @param n [Integer] the number of times each method is called during the benchmark; defaults to 250.
      # @return [nil] Outputs the benchmarking result to stdout and returns nil.
      def bench old, new=nil, n=250
        Benchmark.bm do |b|
          b.report(old) do
            n.times do
              send old.to_sym
            end
          end
          b.report(new) do
            n.times do
              send new.to_sym
            end
          end unless new.nil?
        end
        nil
      end

      # Fetches data for all records of a model, applies optional pagination, and can copy results to the clipboard.
      #
      # @param model [ActiveRecord::Base, ActiveRecord::Relation] the model or scope from which to fetch data.
      # @param options [Hash] options to customize the operation with keys :to_clipboard, :limit, and :offset.
      #   :to_clipboard - when true, copies the data to the clipboard.
      #   :limit - limits the number of records fetched.
      #   :offset - skips a number of records.
      # @return [Array, String] Returns an array of data hashes unless :to_clipboard is true, then returns a string confirmation.
      def get_data_hash model, options = { to_clipboard: false, limit: 1000 }
        res = []
        model = model.all if model.class == Class
        model = model.offset(options[:offset]) if options.key? :offset
        model = model.limit(options[:limit]) if options.key? :limit
        model.each do |m|
          res << self.get_object_data(m)
        end
        # Copy to cliboard if we need to
        if options.key?(:to_clipboard) && options[:to_clipboard]
          pbcopy res
          return 'Copied to Clipboard'
        else
          res
        end
      end

      # Retrieves attribute values for a given ActiveRecord object and formats them in a hash.
      # Dates are wrapped in quotes to ensure proper formatting.
      #
      # @param object [ActiveRecord::Base] the ActiveRecord object from which data is extracted.
      # @return [Hash] a hash where each key is an attribute name and the value is the attribute's value from the object.
      def get_object_data object
        res = {}
        keys = get_attribute_keys object.class
        keys.each do |k|
          # Wrap Date in Quotes
          if object[k].class == ActiveSupport::TimeWithZone
            res[k] = "#{object[k]}"
          else
            res[k] = object[k]
          end
        end
        res
      end

      # Fetches and sorts the attribute names of a given ActiveRecord model class.
      #
      # @param model [Class] the ActiveRecord model class for which to retrieve attribute names.
      # @return [Array<String>] a sorted array of attribute names from the model.
      def get_attribute_keys model
        keys = []
        columns = model.columns.sort_by(&:name)
        columns.each do |col|
          keys << col.name
        end
        keys
      end

      private

      # Annotates an ActiveRecord model with schema details including column names, types, defaults, and indexes.
      # It can optionally output this annotation to the console, copy it to the clipboard, or append it to the model's file.
      #
      # The annotation includes:
      # - Model name and table name.
      # - Each column's name, type (with limit), defaults, and nullability.
      # - Special handling for 'created_at' and 'updated_at' for better readability.
      # - List of indexes on the table, noting which are unique.
      #
      # Annotations are intended to help developers quickly understand the underlying database structure directly
      # from their model files or console output.
      #
      # @param target [Class] the ActiveRecord model class to annotate.
      # @param options [Hash] options to control the output of the annotations:
      #   :to_clipboard - When true, copies the annotation to the system clipboard.
      #   :to_screen - When true, prints the annotation to the console.
      #   :to_file - When true, appends the annotation to the model's file.
      #
      # @example Annotate the User model and output to console and clipboard
      #   annotate_model(User, to_screen: true, to_clipboard: true)
      #
      # @example Annotate the User model and append to the model file
      #   annotate_model(User, to_file: true)
      #
      # @return [void] This method outputs annotations based on the options provided and does not return a value.
      def annotate_model(target, options)
        spc = longest_column_name_length(target) + 3

        res = []
        res << "# --- Model: '#{ActiveModel::Name.new(target).to_s}' Annotation"
        res << "# Table Name: #{target.table_name}"
        res << "#"

        # Getting columns and their details
        columns = target.columns.sort_by(&:name)
        primary_key = target.primary_key
        # Ensure primary key is processed first
        primary_key_column = columns.detect { |col| col.name == primary_key }
        other_columns = columns.reject { |col| col.name == primary_key }
        ordered_columns = [primary_key_column] + other_columns
        indexes = target.connection.indexes(target.table_name)

        created_at = ""
        updated_at = ""

        ordered_columns.each do |col|
          next unless col  # In case primary key column is nil
          type_limit = col.limit.present? ? "#{col.type}(#{col.limit})" : "#{col.type}"

          opts = []
          opts << "Primary Key" if col.name == primary_key
          opts << "default(#{col.default})" if col.default.present?
          opts << "not null" unless col.null

          line = "#  #{col.name.ljust(spc)}:#{type_limit.ljust(15)}#{opts.compact.join(', ')}"

          created_at = line if col.name == 'created_at'
          updated_at = line if col.name == 'updated_at'

          res << line unless col.name == 'created_at' or col.name == 'updated_at'
        end

        # Adding created_at and updated_at at the end for readability
        res << "#" unless created_at.empty? && updated_at.empty?
        res << created_at unless created_at.empty?
        res << updated_at unless updated_at.empty?

        # Append index information at the bottom
        if indexes.any?
          res << "#"
          res << "# Indexes"
          indexes.each do |index|
            res << "#  #{index.name}: #{index.columns.join(', ')}#{' (unique)' if index.unique}"
          end
        end

        # Output options
        puts "--- Model Annotation ---" if options[:to_screen]
        puts res if options[:to_screen]
        puts "---" if options[:to_screen] && !options[:to_clipboard]

        puts "--- Copied to clipboard ---" if options[:to_clipboard]
        pbcopy res if options[:to_clipboard]

        puts "--- Appended to file ---" if options[:to_file]
        write_to_file target, res if options[:to_file]
      end

      # Annotate Controller -- See Annotate above for options
      def annotate_controller target, options

        # target.action_methods iterate through, find the route
        #

        routes = Rails.application.routes.routes
        @r = []
        routes.collect do |r|
          if r.defaults[:controller] == 'home'
            path = r.path.build_formatter
            evals = {}
            r.path.required_names.each do |r|
              evals[r.to_sym] = ":#{r.to_s}"
            end
            @r << { controller: r.defaults[:controller],
                    action: r.defaults[:action],
                    method: r.verb,
                    path: path.evaluate(evals)
            }
          end
        end; nil

        # ActionDispatch::Journey::Route
        # ActionDispatch::Journey::Path::Pattern
        # ActionDispatch::Journey::Format
        #   .evaluate({id: ':id'})


      end

      # Copy to Clipboard
      def pbcopy arg
        IO.popen('pbcopy', 'w') { |io| io.puts arg }
      end

      # Get the longest column name
      def longest_column_name_length target
        target.column_names.sort_by(&:length).last.length
      end

      # Copy to End of File
      def write_to_file target, arg
        # @TODO File Name bug for split name files -- class.to_s.underscore
        model_file = target.name.split("::").map {|c| c.downcase }.join('/') + '.rb'
        file_path = Rails.root.join('app/models/').join(model_file)
        File.open(file_path, "a") { |f| f.puts arg }
      end
    end
  end
end
