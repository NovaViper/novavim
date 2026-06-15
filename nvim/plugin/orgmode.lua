local o = vim.o
-- Make characters hide
o.conceallevel = 2

local org_path = function(path)
  local org_directory = "~/Sync/org"
  return ("%s/%s"):format(org_directory, path)
end

require("orgmode").setup({
  org_agenda_files = { org_path("/**/*"), ("%s/*"):format(vim.fn.getcwd()) },
  org_default_notes_file = org_path("refile.org"),
  org_hide_emphasis_markers = true,
  org_todo_keywords = { "TODO(t)", "PROGRESS(p)", "|", "DONE(d)", "REJECTED(r)" },
})
