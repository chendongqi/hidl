# sign image used to get images' sig files

IMAGE_LIST_TXT := $(wildcard vendor/mediatek/proprietary/custom/$(MTK_PLATFORM_DIR)/security/cert_config/img_list.txt)
IMAGE_SIGN_TOOL := $(wildcard vendor/mediatek/proprietary/scripts/sign-image_v2/sign_flow.py)
ENV_CFG_FILE := $(wildcard vendor/mediatek/proprietary/scripts/sign-image_v2/env.cfg)

define sign-image-in-list
$(PRODUCT_OUT)/$(2):
$(1): $(PRODUCT_OUT)/$(2) $(3) $(4) $(5)
	@echo sign: $$<
	@if [ -f "$$<" ]; then \
          PYTHONDONTWRITEBYTECODE=True \
          PRODUCT_OUT=$(PRODUCT_OUT) \
          BOARD_AVB_ENABLE=$(BOARD_AVB_ENABLE) \
          python $(4) -target $(2) -env_cfg $(5) $$(MTK_PLATFORM_DIR) $$(MTK_BASE_PROJECT); \
         else \
          echo $$< does not exist, no need to sign!; \
         fi
endef

ifndef build-signimage-target
ifneq ($(wildcard $(IMAGE_LIST_TXT)),)
define build-signimage-target
	@echo "v2 sign flow"
	PYTHONDONTWRITEBYTECODE=True PRODUCT_OUT=$(PRODUCT_OUT) BOARD_AVB_ENABLE=$(BOARD_AVB_ENABLE) python $(IMAGE_SIGN_TOOL) -env_cfg $(ENV_CFG_FILE) $(MTK_PLATFORM_DIR) $(MTK_BASE_PROJECT)
endef
else
define build-signimage-target
	@echo "v1 sign flow"
	perl vendor/mediatek/proprietary/scripts/sign-image/SignTool.pl $(MTK_BASE_PROJECT) $(MTK_PROJECT_NAME) $(MTK_PATH_CUSTOM) $(MTK_SEC_SECRO_AC_SUPPORT) $(MTK_NAND_PAGE_SIZE) $(PRODUCT_OUT) $(OUT_DIR)
endef
endif
endif

INSTALLED_SIGNIMAGE_TARGET := $(wildcard $(PRODUCT_OUT)/*-verified.*)
ifneq ($(INSTALLED_SIGNIMAGE_TARGET),)
  BUILT_SIGNIMAGE_TARGET := $(firstword $(INSTALLED_SIGNIMAGE_TARGET))
else
  BUILT_SIGNIMAGE_TARGET := $(PRODCUT_OUT)/boot-verified.img
endif

.PHONY: sign-image sign-image-nodeps
# TODO
#$(BUILT_SIGNIMAGE_TARGET): \
#		$(INSTALLED_BOOTIMAGE_TARGET) \
#		$(INSTALLED_RADIOIMAGE_TARGET) \
#		$(INSTALLED_RECOVERYIMAGE_TARGET) \
#		$(INSTALLED_SYSTEMIMAGE) \
#		$(INSTALLED_USERDATAIMAGE_TARGET) \
#		$(INSTALLED_CACHEIMAGE_TARGET) \
#		$(INSTALLED_VENDORIMAGE_TARGET)
#$(BUILT_SIGNIMAGE_TARGET): \
#		$(filter-out $(TARGET_OUT)/%,$(MTK_MODEM_INSTALLED_MODULES))
#	$(call build-signimage-target)
#
#sign-image: $(BUILT_SIGNIMAGE_TARGET)
#$(BUILT_TARGET_FILES_PACKAGE): $(BUILT_SIGNIMAGE_TARGET)

sign-image-nodeps:
	$(call build-signimage-target)

ifneq ($(INSTALLED_SIGNIMAGE_TARGET),)
$(info Found sign-image: $(INSTALLED_SIGNIMAGE_TARGET))
update-modem: sign-image-nodeps
sign-image-nodeps: snod
sign-image-nodeps: $(filter-out $(TARGET_OUT)/%,$(MTK_MODEM_INSTALLED_MODULES))
endif

ifneq ($(strip $(MTK_MODEM_APPS_FILES)),)
snod vnod: $(call module-installed-files,$(ALL_MODULES.selinux_policy.REQUIRED))
endif

# sign images recorded in img_list.txt
ifeq (yes,$(BOARD_SIGN_IMG))
ifneq (,$(IMAGE_LIST_TXT))
ifneq (,$(IMAGE_SIGN_TOOL))
ifneq (,$(ENV_CFG_FILE))
IMAGE_LIST := $(shell sed -n '/=/ p' $(IMAGE_LIST_TXT))
$(foreach IMAGE_PAIR,$(IMAGE_LIST), \
  $(eval IMAGE_NAME := $(word 1,$(subst =, ,$(IMAGE_PAIR)))) \
  $(if $(filter-out system.img vendor.img,$(IMAGE_NAME)),\
    $(eval IMAGE_BASE_NAME := $(basename $(IMAGE_NAME))) \
    $(eval SIGN_IMAGE_NAME := $(addsuffix -verified$(suffix $(IMAGE_NAME)),$(IMAGE_BASE_NAME))) \
    $(eval SIGN_IMAGE_FILE := $(addprefix $(PRODUCT_OUT)/,$(SIGN_IMAGE_NAME))) \
    $(eval $(call sign-image-in-list,$(SIGN_IMAGE_FILE),$(IMAGE_NAME),$(IMAGE_LIST_TXT),$(IMAGE_SIGN_TOOL),$(ENV_CFG_FILE))) \
    $(eval $(IMAGE_NAME): $(SIGN_IMAGE_FILE)) \
    $(eval droidcore: $(filter-out $(addprefix $(PRODUCT_OUT)/,boot.img recovery.img),$(SIGN_IMAGE_FILE))) \
   ) \
)
endif
endif
endif
endif
