keys := $(strip $(subst =, ,$(shell grep -o "^\s*\w\+\s*=" $(MTK_TARGET_PROJECT_FOLDER)/ProjectConfig.mk)))
keys += \
	HAVE_AEE_FEATURE \
	MTK_BASE_PROJECT \
	MTK_TARGET_PROJECT \
	PRODUCT_LOCALES \
	PRODUCTS \
	TARGET_ARCH \
	TARGET_BOARD_PLATFORM \
	TARGET_BRM_PLATFORM \
	TARGET_BUILD_VARIANT \

SOONG_CONFIG_NAMESPACES += mtkPlugin
SOONG_CONFIG_mtkPlugin := $(keys)
$(foreach key,$(keys),$(eval SOONG_CONFIG_mtkPlugin_$(key):=$($(key))))

# OUT_DIR is exported from Soong_UI
MTK_SOONG_VARIABLES := $(OUT_DIR)/soong/mtk_soong.config

ifeq ($(WRITE_SOONG_VARIABLES),true)

_contents := $(file <$(MTK_TARGET_PROJECT_FOLDER)/ProjectConfig.mk)$(newline)
$(foreach x,$(MTK_PROJECTCONFIG_OVERRIDE),$(eval _contents := $(_contents)$(x)$(newline)))
_contents := $(_contents)PRODUCT_LOCALES = $(PRODUCT_LOCALES)$(newline)
_contents := $(_contents)MTK_TARGET_PROJECT = $(MTK_TARGET_PROJECT)$(newline)
_contents := $(_contents)MTK_BASE_PROJECT = $(MTK_BASE_PROJECT)$(newline)
_contents := $(_contents)PRODUCTS = $(PRODUCTS)$(newline)
_contents := $(_contents)TARGET_ARCH = $(TARGET_ARCH)$(newline)
_contents := $(_contents)TARGET_BOARD_PLATFORM = $(TARGET_BOARD_PLATFORM)$(newline)

$(file >$(MTK_SOONG_VARIABLES).tmp,$(_contents))

$(shell if ! cmp -s $(MTK_SOONG_VARIABLES).tmp $(MTK_SOONG_VARIABLES); then \
	  mv $(MTK_SOONG_VARIABLES).tmp $(MTK_SOONG_VARIABLES); \
	else \
	  rm $(MTK_SOONG_VARIABLES).tmp; \
	fi)

endif#WRITE_SOONG_VARIABLES
