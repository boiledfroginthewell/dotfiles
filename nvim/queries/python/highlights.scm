;; extends

;; Highlight tuples
(tuple) @python.tuple
(tuple "," @python.trailing_tuple_comma .)
(expression_list "," @python.trailing_tuple_comma .)
