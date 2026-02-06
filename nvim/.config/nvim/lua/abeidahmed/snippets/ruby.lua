local status_ok, ls = pcall(require, "luasnip")
if not status_ok then
	return
end

local s = ls.snippet
local t = ls.text_node

return {
	-- Ledger post-deploy script
	s("lpd", {
		t("Ledgers::Seeding::ReseedPatientLedgerRecords.new(patient_id: patient_id).reseed"),
	}),
}
