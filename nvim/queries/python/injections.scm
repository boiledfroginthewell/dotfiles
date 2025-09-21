;extends

; SQL syntax for spark.sql("query string")
(call
	function: (attribute
		object: (identifier) @object_name (#eq? @object_name "spark")
		attribute: (identifier) @function_name (#eq? @function_name "sql")
	)
	arguments: (argument_list
		(string (string_content) @injection.content
			(#set! injection.language "sql")
			(#set! injection.include-children)
		)
	)
)
