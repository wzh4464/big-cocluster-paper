# Name of the main LaTeX file without the extension
MAIN = main

# Detect the operating system
ifeq ($(OS),Windows_NT)
	RM = del /Q
else
	RM = rm -f
endif

# Rule to compile the LaTeX document
all: $(MAIN).pdf

# Rule to compile the LaTeX document (biber support)
$(MAIN).pdf: *.tex *.bib
	latexmk -synctex=1 -interaction=nonstopmode -file-line-error -pdf -use-make $(MAIN).tex
	latexmk -c

clean:
	latexmk -CA
	$(RM) *.bbl *.run.xml
