;; extends

((comment) @injection.language
  .
  (_ (string_fragment) @injection.content)
  (#gsub! @injection.language "[/*#%s]" "")
  (#set! injection.combined)
)
