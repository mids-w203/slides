(TeX-add-style-hook
 "unit_05"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("beamer" "12pt" "block=fill")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("fontenc" "T1") ("ulem" "normalem")))
   (add-to-list 'LaTeX-verbatim-environments-local "semiverbatim")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "beamer"
    "beamer12"
    "graphicx"
    "fontenc"
    "xcolor"
    "txfonts"
    "amsmath"
    "hyperref"
    "pgfpages"
    "ulem")
   (TeX-add-symbols
    '("alex" 1)
    '("paul" 1)
    "E"
    "V"
    "cov"
    "bs"
    "Z"
    "R"
    "N")
   (LaTeX-add-xcolor-definecolors
    "burntOrange"
    "textgray"
    "berkeleyBlue"
    "berkeleyYellow"))
 :latex)

