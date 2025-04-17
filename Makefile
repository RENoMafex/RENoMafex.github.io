.NOTPARALLEL:

SRC_DIR := src
TEMPLATES_DIR := $(SRC_DIR)/templates
OUT_DIR := docs

SRC_FILES := $(filter-out $(TEMPLATES_DIR)/%, $(wildcard $(SRC_DIR)/*))
SRC_BASE := $(basename $(notdir $(SRC_FILES)))
SRC_PAGES := $(filter-out templates, $(SRC_BASE))

OUT_HTML := $(addprefix $(OUT_DIR)/, $(addsuffix .html, $(SRC_PAGES)))

all: $(OUT_HTML)

$(OUT_DIR)/%.html: $(SRC_DIR)/% $(wildcard $(TEMPLATES_DIR)/*)
	@mkdir -p $(OUT_DIR)
	@echo "Generating $@" 1>&2
	@cpp -P -nostdinc -I$(SRC_DIR) $< -o $@
	@echo "Tidy warnings for $@:" 1>&2
	-@tidy -miq --wrap 0 --tidy-mark no\
		--drop-empty-elements no\
		--drop-proprietary-attributes no\
		--output-html yes --show-body-only auto\
		--force-output yes --fix-uri no\
		--merge-divs no --merge-spans no\
		--add-xml-decl no --add-meta-charset no\
		--indent-spaces 2 --doctype omit\
		--enclose-block-text no $@

.PHONY: all prebuild
