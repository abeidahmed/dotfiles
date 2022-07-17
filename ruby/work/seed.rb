user = User.first
organization = Organization.where(dba_name: "Sidekick Therapy Partners").take

# personal details
user.update(first_name: "Abeid", last_name: "Ahmed", slug: "abeidahmed", username: "abeidahmed", time_zone: "Kolkata")

# add user to org
if !user.organizations.include?(organization)
  user.organizations << organization
end

# create a room
Room.find_or_create_by(user: user, organization: organization)

# create a new role for the user
UsersRole.find_or_create_by(user: user, role_id: "9a7b4eb2-c540-4c85-a87a-3387824ddb3e", organization: organization)

# initial permission grant
user.permitted! :indexPermissionsOwn
user.permitted! :indexPermissionsAll
user.permitted! :viewSiteAdminPermissions
user.permitted! :manageUsersPermissions
user.permitted! :giftUserSubscriptions
user.permitted! :viewDashboardSiteAdministration
user.permitted! :siteAdministration
user.permitted! :manageTestimonials
user.permitted! :manageBlogPosts
