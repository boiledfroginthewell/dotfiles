;; extends

; Go-Task
(document
	(block_node
		(block_mapping
			(block_mapping_pair
				key: (_) @anchor (#eq? @anchor "tasks")
				value: (block_node
					(block_mapping
						(block_mapping_pair
							key: (_) @name
						) @symbol (#set! "kind" "Function")
						(#set! custom_outline "true")
					)
				)
			)
		)
	)
)
