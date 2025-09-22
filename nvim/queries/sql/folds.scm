;extends

(subquery (
	[
		(_)
		(ERROR)
	]+ @fold)
)

(select_expression) @fold

(invocation) @fold

(where
	(keyword_where)
	predicate: ((_) @fold)
)
