return {
	-- Not working & jsonlsp stop working by this
	settings = {
		json = {
			schemas = {
				{
					fileMatch = {
						".claude/settings.json",
						".claude.json",
					},
					url = "https://json.schemastore.org/claude-code-settings.json"
				}
			},
			-- allowComments = true
		}
	}
}
