;; extends
(keyed_element
  .
  (literal_element
    (identifier) @variable.member (#set! priority 200)))

(field_declaration
  name: (field_identifier) @variable.member (#set! priority 200))

(const_spec
  name: (identifier) @constant (#set! priority 200))

((escape_sequence) @string.escape (#set! priority 200))

