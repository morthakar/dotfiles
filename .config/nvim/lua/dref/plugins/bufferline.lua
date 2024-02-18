local ok, bufferline = pcall(require, "bufferline")
if not ok then
	return
end

require("bufferline").setup{}
