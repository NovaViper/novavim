;;extends

;; Inject CSS into Python strings with the prefix, css:
((string (string_content) @injection.content)
  (#match? @injection.content "^css:")
  (#set! injection.language "css"))

;; Inject HTML into Python strings with the prefix, html:
((string (string_content) @injection.content)
  (#match? @injection.content "^html:")
  (#set! injection.language "html"))
