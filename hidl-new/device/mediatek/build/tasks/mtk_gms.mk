### GMS + GMO
ifeq ($(strip $(BUILD_GMS)), yes)
ifeq ($(strip $(MTK_GMO_ROM_OPTIMIZE)), yes)

MTK_GMS_CLEAN_MODULES += \
    PrivacyProtectionLock \
    PermissionControl \
    ppl_agent \
    libdrmctaplugin \
    DataProtection \
    MDMLSample \
    MDMConfig

MTK_GMS_CLEAN_FILES := $(strip $(foreach p,$(MTK_GMS_CLEAN_MODULES),$(ALL_MODULES.$(p).INSTALLED)))
$(info [MTK_BUILD_GMS] clean module: $(MTK_GMS_CLEAN_MODULES))

ifneq ($(MTK_GMS_CLEAN_FILES),)
$(info [MTK_BUILD_GMS] rm -rf $(MTK_GMS_CLEAN_FILES))
$(shell rm -rf $(MTK_GMS_CLEAN_FILES))
endif

endif
endif
