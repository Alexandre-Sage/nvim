local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
-- ls.add_snippets("lua", {
-- 	s("hello", { i(1), t("hello world xxxxx"), i(1, "then") })
-- })

ls.add_snippets("typescript", {
	s("logo", { t("console.log({ "), i(1, "key"), t("});") }),
	s("logod", { t("console.dir({ "), i(1, "key"), t("}, { depth: 15 });") }),
	s("clgt", { t("console.time('"), i(1), t("');console.timeEnd('"), i(1), t("');") }),
	s("loghere", { t("console.log('#########################  HERE #########################')") }),
	s("aiife", { t("(async () => {  })();") })
})
