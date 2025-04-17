SRC_DIR := src
TEMPLATES_DIR := $(SRC_DIR)/templates
OUT_DIR := docs

SRC_FILES := $(filter-out $(TEMPLATES_DIR)/%, $(wildcard $(SRC_DIR)/*))
SRC_BASE := $(basename $(notdir $(SRC_FILES)))
SRC_PAGES := $(filter-out templates, $(SRC_BASE))

OUT_HTML := $(addprefix $(OUT_DIR)/, $(addsuffix .html, $(SRC_PAGES)))

$(info Gefundene Seiten: $(SRC_PAGES))
$(info Erzeuge Dateien: $(OUT_HTML))

all: $(OUT_HTML)

$(OUT_DIR)/%.html: $(SRC_DIR)/% $(wildcard $(TEMPLATES_DIR)/*)
	@mkdir -p $(OUT_DIR)
	@echo "Generating $@"
	@cpp -P -nostdinc -I$(SRC_DIR) $< -o $@

clean:
	rm -rf $(OUT_DIR)

.PHONY: all clean
