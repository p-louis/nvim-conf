;; extends

((comment) @injection.language
  .
  (_ (string_fragment) @injection.content)
  (#gsub! @injection.language "[/*#%s]" "")
  (#set! injection.combined)
)

; Bash
(binding
  attrpath: (_) @_path (#hmts-path? @_path "programs" "bash" "(init|logout|profile|bashrc)Extra$")
  expression: (_ (string_fragment) @injection.content)
  (#set! injection.language "bash")
  (#set! injection.combined)
)

; ZSH
(binding
  attrpath: (_) @_path
  (#hmts-path? @_path "programs" "zsh" "(completionInit|envExtra|initContent|loginExtra|logoutExtra|profileExtra)$")
  expression: (_ (string_fragment) @injection.content)
  (#set! injection.language "bash")
  (#set! injection.combined)
) 

; Firefox
(binding
  attrpath: (_) @_path (#hmts-path? @_path "programs" "firefox" "profiles" ".*" "userChrome")
  expression: (_ (string_fragment) @injection.content)
  (#set! injection.language "css")
  (#set! injection.combined)
)

; Polkit
(binding
  attrpath: (_) @_path (#hmts-path? @_path "security" "polkit" "extraConfig")
  expression: (_ (string_fragment) @injection.content)
  (#set! injection.language "javascript")
  (#set! injection.combined)
)

; Wezterm
(binding
  attrpath: (_) @_path (#hmts-path? @_path "programs" "wezterm" "extraConfig")
  expression: (_ (string_fragment) @injection.content)
  (#set! injection.language "lua")
  (#set! injection.combined)
)

; Waybar
(binding
  attrpath: (_) @_path (#hmts-path? @_path "programs" "waybar" "style")
  expression: (_ (string_fragment) @injection.content)
  (#set! injection.language "css")
  (#set! injection.combined)
)
