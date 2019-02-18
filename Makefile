# Makefile for creating an UCL CDT DIS LaTeX document

#------------------------------------------------------------------------------
# By default makes mydocument.pdf using target run_pdflatex.
# Replace mydocument with your main filename or add another target set.
# Adjust FIGSDIR for your figures directory tree.
# Adjust the %.pdf dependencies according to your directory structure.
# Use "make clean" to cleanup.
# Use "make cleanpdf" to delete $(BASENAME).pdf.
# "make cleanall" also deletes the PDF file $(BASENAME).pdf.
# Use "make cleanepstopdf" to rmeove PDF files created automatically from EPS files.
#   Note that FIGSDIR has to be set properly for this to work.

# Set the default target to run_latexmk instead of run_pdflatex to use latexmk to compile.

# If you have to run latex rather than pdflatex adjust the dependencies of %.dvi target
#   and use the command "make run_latex" to compile.
# Specify dvipdf or dvips as the run_latex dependency,
#   depending on which you want to use.

#-------------------------------------------------------------------------------
# Check which TeX Live installation you have with the command pdflatex --version
TEXLIVE  = 2018
LATEX    = latex
PDFLATEX = pdflatex
# BIBTEX   = bibtex
BIBTEX   = biber
DVIPS    = dvips
DVIPDF   = dvipdf

#-------------------------------------------------------------------------------
# The main document filename
BASENAME = mydocument

#-------------------------------------------------------------------------------
# The main document filename
DESTINATION = ../

#-------------------------------------------------------------------------------
# Adjust this according to your top-level figures directory
# This directory tree is used by the "make cleanepstopdf" command
FIGSDIR  = figures
#-------------------------------------------------------------------------------

# EPSTOPDFFILES = `find . -name \*eps-converted-to.pdf`
rwildcard=$(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))
EPSTOPDFFILES = $(call rwildcard, $(FIGSDIR), *eps-converted-to.pdf)

# Default target - make mydocument.pdf with pdflatex
default: run_pdflatex
# Use latexmk instead to compile
# default: run_latexmk

.PHONY: run_latexmk
.PHONY: newgpnote newnotemetadata newgpfiles copymakefile
.PHONY: clean cleanpdf help

# Standard pdflatex target
run_pdflatex: $(BASENAME).pdf
	@echo "Made $<"

# Remove -pdf option to run latex instead of pdflatex
run_latexmk:
	latexmk -pdf $(BASENAME)

#-------------------------------------------------------------------------------
# Specify the tex and bib file dependencies for running pdflatex
# If your bib files are not in the main directory adjust this target accordingly
#%.pdf:	%.tex *.tex bib/*.bib
%.pdf:	%.tex *.tex *.bib
	$(PDFLATEX) $<
	-$(BIBTEX)  $(basename $<)
	$(PDFLATEX) $<
	$(PDFLATEX) $<
#-------------------------------------------------------------------------------

# Default is to make a new group project note 
new: newgp

newgp: TEMPLATE=groupproject
newgp: newgpnote newgpfiles newnotemetadata copymakefile

newgpnote:
	if [ $(TEXLIVE) -ge 2007 -a $(TEXLIVE) -lt 2100 ]; then \
	  sed s/dis-gp/$(BASENAME)/ template/$(TEMPLATE).tex > $(DESTINATION)$(BASENAME).tex; \
	else \
	  echo "Invalid value for TEXLIVE: $(TEXLIVE)"; \
	fi

newnotemetadata:
	cp template/dis-$(TEMPLATE)-metadata.tex $(DESTINATION)$(BASENAME)-metadata.tex;

newgpfiles:
	echo "% Put you own bibliography entries in this file" > $(DESTINATION)$(BASENAME).bib;
	touch $(DESTINATION)$(BASENAME)-defs.sty;

copymakefile:
	echo "Add a makefile for the new report";
	sed s/BASENAME\ =\ mydocument/BASENAME\ =\ $(BASENAME)/ Makefile > $(DESTINATION)Makefile;

run_latex: dvipdf

# Targets if you run latex instead of pdflatex
dvipdf:	$(BASENAME).dvi
	$(DVIPDF) -sPAPERSIZE=a4 -dPDFSETTINGS=/prepress $<
	@echo "Made $(basename $<).pdf"

dvips:	$(BASENAME).dvi
	$(DVIPS) $<
	@echo "Made $(basename $<).ps"

# Specify dependencies for running latex
#%.dvi:	%.tex tex/*.tex bibtex/bib/*.bib
%.dvi:	%.tex *.tex *.bib
	$(LATEX)    $<
	-$(BIBTEX)  $(basename $<)
	$(LATEX)    $<
	$(LATEX)    $<

%.bbl:	%.tex *.bib
	$(LATEX) $<
	$(BIBTEX) $<

help:
	@echo "To create a new UCL CDT DIS Group Project note draft give the command:"
	@echo "make newgpnote [BASENAME=mydocument]"
	@echo ""
	@echo "To compile the paper give the command"
	@echo "make"
	@echo "If your bib files are not in the main directory, adjust the %.pdf target accordingly." 
	@echo ""
	@echo "To compile the document using latexmk give the command:"
	@echo "make latexmk"
	@echo "You can also adjust the 'default' target."
	@echo ""
	@echo "make clean    to clean auxiliary files (not output PDF)"
	@echo "make cleanpdf to clean output PDF files"
	@echo "make cleanps  to clean output PS files"
	@echo "make cleanall to clean all files"
	@echo "make cleanepstopdf to clean PDF files automatically made from EPS"
	@echo ""

clean:
	-rm *.dvi *.toc *.aux *.log *.out \
		*.bbl *.blg *.brf *.bcf *-blx.bib *.run.xml \
		*.cb *.ind *.idx *.ilg *.inx \
		*.synctex.gz *~ *.fls *.fdb_latexmk .*.lb spellTmp 

cleanpdf:
	-rm $(BASENAME).pdf 
	-rm $(BASENAME)-draft-cover.pdf 

cleanps:
	-rm $(BASENAME).ps 
	-rm $(BASENAME)-draft-cover.ps 

cleanall: clean cleanpdf cleanps

# Clean the PDF files created automatically from EPS files
cleanepstopdf: $(EPSTOPDFFILES)
	@echo "Removing PDF files made automatically from EPS files"
	-rm $^
