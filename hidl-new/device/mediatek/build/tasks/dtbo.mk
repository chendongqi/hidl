ifneq ($(filter $(OUT_DIR)/%,$(BOARD_PREBUILT_DTBOIMAGE)),)

.KATI_RESTAT: $(KERNEL_OUT)/dtboimg.cfg
$(KERNEL_OUT)/dtboimg.cfg: $(KERNEL_ZIMAGE_OUT) ;

# mkdtimg is from system/libufdt/utils/src
$(BOARD_PREBUILT_DTBOIMAGE): PRIVATE_TOOL := $(HOST_OUT_EXECUTABLES)/mkdtimg
$(BOARD_PREBUILT_DTBOIMAGE): PRIVATE_CFG := $(KERNEL_OUT)/dtboimg.cfg
$(BOARD_PREBUILT_DTBOIMAGE): $(HOST_OUT_EXECUTABLES)/mkdtimg
$(BOARD_PREBUILT_DTBOIMAGE): $(KERNEL_OUT)/dtboimg.cfg
	$(hide) mkdir -p $(dir $@)
	$(PRIVATE_TOOL) cfg_create $@ $(PRIVATE_CFG)

ifeq ($(strip $(MTK_DTBO_UPGRADE_FROM_ANDROID_O)), yes)
droidcore: $(PRODUCT_OUT)/$(notdir $(BOARD_PREBUILT_DTBOIMAGE))
odmdtboimage: $(PRODUCT_OUT)/$(notdir $(BOARD_PREBUILT_DTBOIMAGE))
else
droidcore: $(PRODUCT_OUT)/dtbo.img
dtboimage: $(PRODUCT_OUT)/dtbo.img
endif
$(PRODUCT_OUT)/recovery.img: $(BOARD_PREBUILT_DTBOIMAGE)

endif#BOARD_PREBUILT_DTBOIMAGE
