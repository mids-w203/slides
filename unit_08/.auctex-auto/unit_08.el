(TeX-add-style-hook
 "unit_08"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("beamer" "12pt" "block=fill")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("FiraSans" "sfdefault") ("fontenc" "T1")))
   (TeX-run-style-hooks
    "latex2e"
    "beamer"
    "beamer12"
    "FiraSans"
    "FiraMono"
    "fontenc"
    "xcolor"
    "pgfpages")
   (TeX-add-symbols
    "E"
    "V"
    "cov"))
 :latex)

