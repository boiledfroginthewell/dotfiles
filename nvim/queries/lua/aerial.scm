;; extends

; Lazy plugins
;; Direct plugins
(chunk
	(return_statement
		(expression_list
			(table_constructor
				(field value: [
					(table_constructor
						(field
							!name
							value: (string content: (string_content) @name)
						)
					)
					(string content: (string_content) @name)
				]) @symbol (#set! "kind" "Package")
				(#set! "custom_outline" "true")
			)
		)
	)
)

;; Plugin dependencies
(field
	name: (identifier) @dependencies (#eq? @dependencies "dependencies")
	value: (table_constructor
		(field value: [
			(table_constructor
				(field
					!name
					value: (string content: (string_content) @name)
				)
			)
			(string content: (string_content) @name)
		]) @symbol (#set! "kind" "Package")
		(#set! custom_outline "true")
	)
)
