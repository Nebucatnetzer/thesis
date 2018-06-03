(TeX-add-style-hook
 "style"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("glossaries" "acronym" "toc") ("geometry" "a4paper" "includeheadfoot" "top=2.5cm" "bottom=2.5cm" "left=3.5cm" "right=3cm") ("fontenc" "T1") ("inputenc" "utf8") ("babel" "ngerman") ("footmisc" "bottom" "hang") ("xcolor" "table" "xcdraw") ("tcolorbox" "most") ("biblatex" "citestyle=verbose" "bibstyle=numeric" "sorting=none" "backend=bibtex8")))
   (add-to-list 'LaTeX-verbatim-environments-local "lstlisting")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "lstinline")
   (TeX-run-style-hooks
    "hyperref"
    "graphicx"
    "xcolor"
    "glossaries"
    "xparse"
    "geometry"
    "tgpagella"
    "fontenc"
    "inputenc"
    "babel"
    "microtype"
    "fancyhdr"
    "footmisc"
    "titlesec"
    "longtable"
    "rotating"
    "pdflscape"
    "float"
    "listings"
    "color"
    "sourcecodepro"
    "tcolorbox"
    "tocbibind"
    "biblatex")
   (TeX-add-symbols
    "newdualentry"
    "sectionbreak")
   (LaTeX-add-color-definecolors
    "red"
    "pink"
    "purple"
    "brown"
    "cyan"
    "darkgray"
    "gray"
    "lightgray"
    "lime"
    "olive"
    "orange"
    "teal"
    "yellow"
    "green"))
 :latex)

