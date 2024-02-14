; extends

; namespaces

(package_header
  "package" @keyword.module)

(import_header
  (identifier
    (simple_identifier) @module (#match? @module "^[a-z0-9]+$")
    (simple_identifier) .))
