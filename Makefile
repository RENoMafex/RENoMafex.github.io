.PHONY: all
.NOTPARALLEL:

SRC_DIR := src
TEMPLATES_DIR := $(SRC_DIR)/templates
OUT_DIR := docs

SRC_HTML := $(wildcard $(SRC_DIR)/*.html)
OUT_HTML := $(addprefix $(OUT_DIR)/, $(notdir $(SRC_HTML)))

SRC_CSS := $(wildcard $(SRC_DIR)/*.css)
OUT_CSS := $(addprefix $(OUT_DIR)/, $(notdir $(SRC_CSS)))


all: $(OUT_HTML) $(OUT_CSS)

$(OUT_DIR)/%.html: $(SRC_DIR)/%.html $(wildcard $(TEMPLATES_DIR)/*)
	@echo "Generating $@" 1>&2
	@cpp -P -nostdinc -I$(TEMPLATES_DIR) $< -o $@
	@echo "Starting \"tidy\" for $@" 1>&2
	@tidy -miq --wrap 0 --tidy-mark no\
		--drop-empty-elements no\
		--drop-proprietary-attributes no\
		--output-html yes --show-body-only auto\
		--force-output yes --fix-uri no\
		--merge-divs no --merge-spans no\
		--add-xml-decl no --add-meta-charset no\
		--indent-spaces 4\
		--enclose-block-text no $@\
		|| true

$(OUT_DIR)/%.css: $(SRC_DIR)/%.css
	@echo "Replacing $@"
	@cp -f $< $@

