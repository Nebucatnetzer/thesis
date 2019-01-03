ALL=$(wildcard *.sty *.tex *.org pictures/*.svg pictures/*.eps pictures/*.dot \
	pictures/*.tex pictures/*.puml)
PAPER=Projektdokumentation_Andreas_Zweili.tex
SHELL=/bin/bash

FIGURES_SVG=$(wildcard pictures/*.svg)
FIGURES_EPS=$(wildcard pictures/*.eps)
FIGURES_DOT=$(wildcard pictures/*.dot)
FIGURES_TEX=$(wildcard pictures/*.tex)
FIGURES_PUML=$(wildcard pictures/*.puml)
BIBLIOGRAPHY=$(wildcard general/*.bib)
SVG_PDF=$(FIGURES_SVG:.svg=.pdf)
EPS_PDF=$(FIGURES_EPS:.eps=.pdf)
DOT_PDF=$(FIGURES_DOT:.dot=.pdf)
TEX_PDF=$(FIGURES_TEX:.tex=.pdf)
PUML_PDF=$(FIGURES_PUML:.puml=.svg)

all: Projektdokumentation_Andreas_Zweili.pdf ## Build full thesis (LaTeX + figures)

Projektdokumentation_Andreas_Zweili.pdf: $(SVG_PDF) $(EPS_PDF) $(DOT_PDF) $(TEX_PDF) \
	$(PUML_PDF) projekthandbuch.tex general/ibzlogo.pdf $(BIBLIOGRAPHY)
	latexmk -quiet -pdf -pdflatex="pdflatex -interaction=nonstopmode" \
	-use-make $(PAPER)

clean:  ## Clean LaTeX and output figure files
	latexmk -c $(PAPER)
	rm -f $(SVG_PDF)
	rm -f $(EPS_PDF)
	rm -f $(DOT_PDF)
	rm -f $(PUML_PDF)
	rm -f general/ibzlogo.pdf
	rm -f *.acn
	rm -f *.acr
	rm -f *.bbl
	rm -f *.glo
	rm -f *.ist
	rm -f *.alg
	rm -f *.glg
	rm -f *.gls
	rm -f *.lol
	rm -f *.run.xml
	rm -f *-blx.bib
	rm -f *.listing
	rm -rf auto/
	rm -rf general/auto/
	rm -rf general/*.aux
	rm -f projekthandbuch.tex
	rm *.zip

distclean:
	rm -f Projektdokumentation_Andreas_Zweili.pdf

pictures/%.pdf: pictures/%.svg  ## Figures for the manuscript
	inkscape -C -z --file=$< --export-pdf=$@

pictures/%.pdf: pictures/%.eps  ## Figures for the manuscript
	inkscape -C -z --file=$< --export-pdf=$@

general/ibzlogo.pdf: general/ibzlogo.svg
	inkscape -C -z --file=$< --export-pdf=$@

pictures/%.pdf: pictures/%.dot  ## Figures for the manuscript
	dot -Tpdf $< -o $@

pictures/%.pdf: pictures/%.tex  ## Figures for the manuscript
	latexmk -quiet -pdf -outdir=pictures \
	-pdflatex="pdflatex -interaction=nonstopmode" -use-make $<

pictures/%.svg: pictures/%.puml
	java -jar ~/bin/plantuml.jar -tsvg $<

projekthandbuch.tex: projektdokumentation.org
	emacs -l general/thesis.el --batch \
	--eval="(progn (find-file \"projektdokumentation.org\") (org-latex-export-to-latex nil nil nil t))"
	replace-listings.sh projektdokumentation.tex

final: Projektdokumentation_Andreas_Zweili.pdf
	zip -r Projektdokumentation_Andreas_Zweili.zip \
		Projektdokumentation_Andreas_Zweili.pdf \
		Zeitplanung_Andreas_Zweili.html
