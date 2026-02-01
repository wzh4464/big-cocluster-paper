# DiMergeCo paper – build system
# All LaTeX sources live under src/; output goes to build/<target>/

SRC_DIR   := src
BUILD_DIR := build

# Detect OS for rm command
ifeq ($(OS),Windows_NT)
	RM = del /Q
else
	RM = rm -rf
endif

# ---------- individual targets ----------

.PHONY: all root response supplement cover_letter clean

all: root response supplement cover_letter

root:
	@mkdir -p $(BUILD_DIR)/root
	cd $(SRC_DIR) && latexmk -cd -pdf -interaction=nonstopmode -file-line-error \
		-outdir=../$(BUILD_DIR)/root root.tex

# response depends on root (needs root.aux for \externaldocument)
response: root
	@mkdir -p $(BUILD_DIR)/response
	cd $(SRC_DIR) && latexmk -cd -pdf -interaction=nonstopmode -file-line-error \
		-outdir=../$(BUILD_DIR)/response response.tex

supplement:
	@mkdir -p $(BUILD_DIR)/supplement
	cd $(SRC_DIR) && latexmk -cd -pdf -interaction=nonstopmode -file-line-error \
		-outdir=../$(BUILD_DIR)/supplement supplement.tex

cover_letter:
	@mkdir -p $(BUILD_DIR)/cover_letter
	cd $(SRC_DIR) && latexmk -cd -pdf -interaction=nonstopmode -file-line-error \
		-outdir=../$(BUILD_DIR)/cover_letter cover_letter.tex

# ---------- clean ----------

clean:
	$(RM) $(BUILD_DIR)
