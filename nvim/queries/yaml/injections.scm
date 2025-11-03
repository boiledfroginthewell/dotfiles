;extends

; Argo
; script
(block_mapping_pair
	key: (_) @script_key (#eq? @script_key "script")
	value: (block_node
		(block_mapping
      (block_mapping_pair
        key: (_) @command_key (#eq? @command_key "command")
        value: [
					(flow_node
						(flow_sequence
							(flow_node (_) @injection.language)
						)
					)
					(block_node
						(block_sequence
							(block_sequence_item (_) @injection.language)
						)
					)
				]
				(#gsub! @injection.language "[\"']" "")
      )
			(block_mapping_pair
				key: (_) @source_key (#eq? @source_key "source")
				value: (_) @injection.content
          (#set! injection.language "bash")
          (#set! injection.include-children)
          (#offset! @injection.content 1 -10 0 0)
			)
		)
	)
)

