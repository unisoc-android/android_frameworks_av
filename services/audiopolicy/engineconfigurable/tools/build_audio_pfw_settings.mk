LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_ADDITIONAL_DEPENDENCIES += \
    $(HOST_OUT_EXECUTABLES)/domainGeneratorPolicy.py \
    $(PFW_TOPLEVEL_FILE) $(PFW_CRITERIA_FILE) $(PFW_CRITERION_TYPES_FILE)

LOCAL_HOST_DOMAINGENERATORCONNECTOR = $(HOST_OUT_EXECUTABLES)/domainGeneratorConnector

include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE): MY_CRITERION_TYPES_FILE := $(PFW_CRITERION_TYPES_FILE)
$(LOCAL_BUILT_MODULE): MY_TOOL := $(HOST_OUT_EXECUTABLES)/domainGeneratorPolicy.py
$(LOCAL_BUILT_MODULE): MY_TOPLEVEL_FILE := $(PFW_TOPLEVEL_FILE)
$(LOCAL_BUILT_MODULE): MY_CRITERIA_FILE := $(PFW_CRITERIA_FILE)
$(LOCAL_BUILT_MODULE): MY_TUNING_FILE := $(PFW_TUNING_FILE)
$(LOCAL_BUILT_MODULE): MY_EDD_FILES := $(PFW_EDD_FILES)
$(LOCAL_BUILT_MODULE): MY_DOMAIN_FILES := $(PFW_DOMAIN_FILES)
$(LOCAL_BUILT_MODULE): MY_SCHEMAS_DIR := $(PFW_SCHEMAS_DIR)
$(LOCAL_BUILT_MODULE): MY_CRITERION_TYPES_FILE := $(PFW_CRITERION_TYPES_FILE)
$(LOCAL_BUILT_MODULE): $(LOCAL_ADDITIONAL_DEPENDENCIES)

	"$(MY_TOOL)" --tool "$(LOCAL_HOST_DOMAINGENERATORCONNECTOR)" \
		--validate \
		--toplevel-config "$(MY_TOPLEVEL_FILE)" \
		--criteria "$(MY_CRITERIA_FILE)" \
		--criteriontypes "$(MY_CRITERION_TYPES_FILE)" \
		--initial-settings $(MY_TUNING_FILE) \
		--add-edds $(MY_EDD_FILES) \
		--add-domains $(MY_DOMAIN_FILES) \
		--schemas-dir $(MY_SCHEMAS_DIR) > "$@"


# Clear variables for further use
PFW_TOPLEVEL_FILE :=
PFW_STRUCTURE_FILES :=
PFW_CRITERIA_FILE :=
PFW_CRITERION_TYPES_FILE :=
PFW_TUNING_FILE :=
PFW_EDD_FILES :=
PFW_DOMAIN_FILES :=
PFW_SCHEMAS_DIR := $(PFW_DEFAULT_SCHEMAS_DIR)
