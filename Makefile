# Name of the main LaTeX file without the extension
MAIN = main

# Detect the operating system
ifeq ($(OS),Windows_NT)
	RM = del /Q
else
	RM = rm -f
endif

# Directories to watch
TEX_DIRS = . sections/
IMG_DIRS = images/
BIB_FILES = *.bib

# Rule to compile the LaTeX document
all: $(MAIN).pdf

# Rule to compile the LaTeX document (biber support)
$(MAIN).pdf: $(foreach dir,$(TEX_DIRS),$(wildcard $(dir)*.tex)) $(foreach dir,$(IMG_DIRS),$(wildcard $(dir)*)) $(BIB_FILES)
	latexmk -synctex=1 -interaction=nonstopmode -file-line-error -pdf -use-make $(MAIN).tex
	latexmk -c
clean:
	latexmk -CA
	$(RM) *.bbl *.run.xml
