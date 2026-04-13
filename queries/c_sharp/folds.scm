; extends

; Fold declarations from the signature line, not only from the opening brace.
[
  (class_declaration)
  (struct_declaration)
  (interface_declaration)
  (enum_declaration)
  (record_declaration)
  (namespace_declaration)
  (file_scoped_namespace_declaration)
  (constructor_declaration)
  (destructor_declaration)
  (method_declaration)
  (local_function_statement)
  (operator_declaration)
  (conversion_operator_declaration)
  (property_declaration)
  (indexer_declaration)
  (event_declaration)
  (event_field_declaration)
] @fold
