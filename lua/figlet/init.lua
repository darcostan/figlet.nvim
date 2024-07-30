--Global Settings-----------------------------------------------------------------------------------
Font = "big"
---------------------------------------------------------------------------------------------------
local function setup(config)
	Font = config.font
end

local function Fig(arg1)
	vim.api.nvim_command(":read !figlet -f " .. Font .. " " .. arg1)
end

local function GetLine()
	local curr_line = vim.api.nvim_win_get_cursor(0)[1]
	print(curr_line)
	return curr_line
end

local function FigComment(arg1)
	local Font = arg1.last
	vim.api.nvim_command(":read !figlet -f " .. Font .. " " .. arg1)
	require("Comment.api").toggle.linewise("line")
end

local function FigCommentWithHighlight(arg1)
	local start_line = GetLine()
	vim.api.nvim_command(":read !figlet -f " .. Font .. " " .. arg1)
	require("Comment.api").toggle.linewise("line")
	vim.api.nvim_command("normal o")
	vim.api.nvim_command("normal x")
	local stop_line = GetLine()
	for i = start_line, stop_line do
		vim.api.nvim_buf_add_highlight(0, -1, "ErrorMsg", i, 0, -1)
	end
end

local function FigList()
	vim.api.nvim_command(":!figlist")
end

-- TODO: Visual select into figlet
local function FigSelect()
	local arg1 = vim.fn.getline(".")
	Fig(arg1)
end

local function FigSelectComment()
	local arg1 = vim.fn.getline(".")
	FigComment(arg1)
end

return {
	sertup = setup,
	Fig = Fig,
	FigComment = FigComment,
	FigCommentWithHighlight = FigCommentWithHighlight,
	FigList = FigList,
	FigSelect = FigSelect,
	FigSelectComment = FigSelectComment,
}
