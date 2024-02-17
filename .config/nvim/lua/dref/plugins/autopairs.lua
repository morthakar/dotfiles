-- Setup nvim-cmp.
local ok, autopairs = pcall(require, "nvim-autopairs")
if not ok then
	return
end

autopairs.setup {}

local has_cmp_autopairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if not has_cmp_autopairs then
	return
end

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
