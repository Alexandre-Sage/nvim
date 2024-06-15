local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
-- ls.add_snippets("lua", {
-- 	s("hello", { i(1), t("hello world xxxxx"), i(1, "then") })
-- })

ls.add_snippets("rust", {
	s("log", { t("println!(\"########## Here ##########:\n{}\","), i(1, "key"), t(");") }),
})
