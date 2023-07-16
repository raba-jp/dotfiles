return {
	{ "Olical/nfnl", ft = "fennel" },
	{
		"Olical/conjure",
		ft = { "clojure", "fennel" },
		dependencies = {
			{
				"PaterJason/cmp-conjure",
				config = function()
					local cmp = require("cmp")
					local config = cmp.get_config()
					table.insert(config.sources, {
						name = "buffer",
						option = {
							sources = {
								{ name = "conjure" },
							},
						},
					})
					cmp.setup(config)
				end,
			},
		},
		config = function(_, _opts)
			require("conjure.main").main()
			require("conjure.mapping")["on-filetype"]()
		end,
	},
}
