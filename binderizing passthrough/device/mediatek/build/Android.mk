LOCAL_PATH := $(call my-dir)

ifneq ($(TARGET_DEVICE), gobo)

ifeq ($(is_sdk_build),true)
$(shell if [ ! -e $(HOST_OUT)/sdk/$(TARGET_PRODUCT)/sdk_deps.mk ]; then mkdir -p $(HOST_OUT)/sdk/$(TARGET_PRODUCT) && echo "-include device/mediatek/build/core/sdk_deps.mk" > $(HOST_OUT)/sdk/$(TARGET_PRODUCT)/sdk_deps.mk; fi)
endif

ifdef TARGET_2ND_ARCH

define mtk-add-vndk-lib
include $$(CLEAR_VARS)
LOCAL_MODULE := $(1)$(2)
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_PREBUILT_MODULE_FILE := $$(TARGET_OUT_INTERMEDIATE_LIBRARIES)/$(1).so
LOCAL_MULTILIB := 64
LOCAL_MODULE_TAGS := optional
LOCAL_INSTALLED_MODULE_STEM := $(1).so
LOCAL_MODULE_SUFFIX := .so
LOCAL_VENDOR_MODULE := $(3)
LOCAL_MODULE_RELATIVE_PATH := $(4)
include $$(BUILD_PREBUILT)

include $$(CLEAR_VARS)
LOCAL_MODULE := $(1)$(2)
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_PREBUILT_MODULE_FILE := $$($$(TARGET_2ND_ARCH_VAR_PREFIX)TARGET_OUT_INTERMEDIATE_LIBRARIES)/$(1).so
LOCAL_MULTILIB := 32
LOCAL_MODULE_TAGS := optional
LOCAL_INSTALLED_MODULE_STEM := $(1).so
LOCAL_MODULE_SUFFIX := .so
LOCAL_VENDOR_MODULE := $(3)
LOCAL_MODULE_RELATIVE_PATH := $(4)
include $$(BUILD_PREBUILT)

ALL_MODULES.$(1).REQUIRED := $$(strip $$(ALL_MODULES.$(1).REQUIRED) $(1)$(2))
ALL_MODULES.$(1)$$(TARGET_2ND_ARCH_MODULE_SUFFIX).REQUIRED := $$(strip $$(ALL_MODULES.$(1)$$(TARGET_2ND_ARCH_MODULE_SUFFIX).REQUIRED) $(1)$(2))
TARGET_DEPENDENCIES_ON_SHARED_LIBRARIES := $$(filter-out $(1)$(2):%,$$(TARGET_DEPENDENCIES_ON_SHARED_LIBRARIES))
2ND_TARGET_DEPENDENCIES_ON_SHARED_LIBRARIES := $$(filter-out $(1)$(2)$$(TARGET_2ND_ARCH_MODULE_SUFFIX):%,$$(2ND_TARGET_DEPENDENCIES_ON_SHARED_LIBRARIES))
endef

else

define mtk-add-vndk-lib
include $$(CLEAR_VARS)
LOCAL_MODULE := $(1)$(2)
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_PREBUILT_MODULE_FILE := $$(TARGET_OUT_INTERMEDIATE_LIBRARIES)/$(1).so
LOCAL_MULTILIB := 32
LOCAL_MODULE_TAGS := optional
LOCAL_INSTALLED_MODULE_STEM := $(1).so
LOCAL_MODULE_SUFFIX := .so
LOCAL_VENDOR_MODULE := $(3)
LOCAL_MODULE_RELATIVE_PATH := $(4)
include $$(BUILD_PREBUILT)

ALL_MODULES.$(1).REQUIRED := $$(strip $$(ALL_MODULES.$(1).REQUIRED) $(1)$(2))
TARGET_DEPENDENCIES_ON_SHARED_LIBRARIES := $$(filter-out $(1)$(2):%,$$(TARGET_DEPENDENCIES_ON_SHARED_LIBRARIES))
endef

endif

# clone from system/lib to vendor/lib
AOSP_VNDK_EXT_LIBRARIES :=

# clone from system/lib to system/lib/vndk-sp

ifneq ($(BUILD_QEMU_IMAGES),true)

ifndef BOARD_VNDK_VERSION
AOSP_VNDK_SP_LIBRARIES := \
    android.hardware.graphics.allocator@2.0 \
    android.hardware.graphics.mapper@2.0 \
    android.hardware.graphics.common@1.0 \
    android.hardware.renderscript@1.0 \
    android.hidl.base@1.0 \
    android.hidl.memory@1.0 \
    libRSCpuRef \
    libRSDriver \
    libRS_internal \
    libbacktrace \
    libbase \
    libbcinfo \
    libblas \
    libc++ \
    libcompiler_rt \
    libcutils \
    libft2 \
    libhardware \
    libhidlbase \
    libhidlmemory \
    libhidltransport \
    libhwbinder \
    libion \
    liblzma \
    libpng \
    libunwind \
    libutils \

endif

else

AOSP_VNDK_SP_LIBRARIES ?=

endif


# clone from vendor/lib to system/lib
MTK_VNDK_EXT_LIBRARIES := \


#
$(foreach lib,$(AOSP_VNDK_EXT_LIBRARIES),$(eval $(call mtk-add-vndk-lib,$(lib),_vnd,true)))
$(foreach lib,$(AOSP_VNDK_SP_LIBRARIES),$(eval $(call mtk-add-vndk-lib,$(lib),.vndk-sp,,vndk-sp)))
$(foreach lib,$(MTK_VNDK_EXT_LIBRARIES),$(eval $(call mtk-add-vndk-lib,$(lib),_fwk)))
endif




# $(1): base module name
# $(2): new module name suffix
# $(3): arm64 install path
# $(4): arm install path

define mtk-rsc-add-shared-library

ifneq ($$(TARGET_2ND_ARCH),)
include $$(CLEAR_VARS)
LOCAL_MODULE := $(1)$(2)
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_PREBUILT_MODULE_FILE := $$(call intermediates-dir-for,SHARED_LIBRARIES,$(1),,,,)/$(1).so
LOCAL_STRIP_MODULE := false
LOCAL_MULTILIB := 64
LOCAL_INSTALLED_MODULE_STEM := $(1).so
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_PATH := $(3)
include $(if $(3),$$(BUILD_PREBUILT))
endif

include $$(CLEAR_VARS)
LOCAL_MODULE := $(1)$(2)
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
ifneq ($$(TARGET_2ND_ARCH),)
LOCAL_PREBUILT_MODULE_FILE := $$(call intermediates-dir-for,SHARED_LIBRARIES,$(1),,,$$(TARGET_2ND_ARCH_VAR_PREFIX),)/$(1).so
else
LOCAL_PREBUILT_MODULE_FILE := $$(call intermediates-dir-for,SHARED_LIBRARIES,$(1),,,,)/$(1).so
endif
LOCAL_STRIP_MODULE := false
LOCAL_MULTILIB := 32
LOCAL_INSTALLED_MODULE_STEM := $(1).so
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_PATH := $(4)
include $(if $(4),$$(BUILD_PREBUILT))

endef


define mtk-rsc-add-executable

include $$(CLEAR_VARS)
LOCAL_MODULE := $(1)$(2)
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_PREBUILT_MODULE_FILE := $$(call intermediates-dir-for,EXECUTABLES,$(1),,,,)/$(1)
LOCAL_STRIP_MODULE := false
LOCAL_MULTILIB := 64
LOCAL_MODULE_PATH := $(3)
include $(if $(3),$$(BUILD_PREBUILT))

include $$(CLEAR_VARS)
LOCAL_MODULE := $(1)$(2)
LOCAL_MODULE_CLASS := EXECUTABLES
ifneq ($$(TARGET_2ND_ARCH),)
LOCAL_PREBUILT_MODULE_FILE := $$(call intermediates-dir-for,EXECUTABLES,$(1),,,$$(TARGET_2ND_ARCH_VAR_PREFIX),)/$(1)
else
LOCAL_PREBUILT_MODULE_FILE := $$(call intermediates-dir-for,EXECUTABLES,$(1),,,,)/$(1)
endif
LOCAL_STRIP_MODULE := false
LOCAL_MULTILIB := 32
LOCAL_MODULE_PATH := $(4)
include $(if $(4),$$(BUILD_PREBUILT))

endef


define mtk-rsc-add-java-library

include $$(CLEAR_VARS)
LOCAL_MODULE := $(1)$(2)
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_PREBUILT_MODULE_FILE := $$(call intermediates-dir-for,JAVA_LIBRARIES,$(1),,,,)/javalib.jar
LOCAL_MULTILIB := first
LOCAL_INSTALLED_MODULE_STEM := $(1).jar
LOCAL_MODULE_SUFFIX := .jar
LOCAL_MODULE_PATH := $(3)
include $$(BUILD_PREBUILT)

endef


define mtk-rsc-add-package

include $$(CLEAR_VARS)
LOCAL_MODULE := $(1)$(2)
LOCAL_MODULE_CLASS := APPS
LOCAL_PREBUILT_MODULE_FILE := $$(call intermediates-dir-for,APPS,$(1),,,,)/package.apk
LOCAL_MULTILIB := first
LOCAL_INSTALLED_MODULE_STEM := $(1)/$(1).apk
LOCAL_MODULE_SUFFIX := .apk
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE_PATH := $(3)
LOCAL_IS_RUNTIME_RESOURCE_OVERLAY := true
LOCAL_DEX_PREOPT := $(4)
include $$(BUILD_PREBUILT)

$$(call intermediates-dir-for,APPS,$(1),,,,)/package.apk: dexpreopt-remove-classes.dex =

endef


mtk_rsc_override_modules :=
mtk_rsc_required_modules :=
mtk_rsc_check :=
define mtk_rsc_check_fail
$(eval mtk_rsc_check += error)\
$(warning $(1))
endef

$(foreach mk, $(PRODUCT_MTK_RSC_NAMES),\
  $(eval mtk_rsc_name := $(mk))\
  $(eval include device/mediatek/build/tasks/tools/build_mtk_rsc.mk))

ifneq ($(strip $(mtk_rsc_check)),)
$(error RSC check fail)
endif


include $(CLEAR_VARS)
LOCAL_MODULE := rsc.xml
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_OWNER := mtk
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES := $(mtk_rsc_required_modules)
intermediates := $(call intermediates-dir-for,$(LOCAL_MODULE_CLASS),$(LOCAL_MODULE))
$(intermediates)/gen.xml: PRIVATE_PTGEN := $(PRODUCT_OUT)/$(MTK_PTGEN_CHIP)_Android_scatter.txt
$(intermediates)/gen.xml: $(PRODUCT_OUT)/$(MTK_PTGEN_CHIP)_Android_scatter.txt
$(intermediates)/gen.xml: $(MTK_RSC_MAKEFILES)
	@mkdir -p $(dir $@)
	@echo "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>" >$@
	@echo "<runtime_switchable_config version=\"1\">" >>$@
	@echo "<magic>0x5253434D</magic>" >>$@
	@echo "  <part_info>" >>$@
	@echo -n "    <name>" >>$@
	@echo -n $$(cat $(PRODUCT_OUT)/$(MTK_PTGEN_CHIP)_Android_scatter.txt | grep "partition_name: \(para\|misc\)" | sed -e 's/  partition_name: //' | uniq) >>$@
	@echo "</name>" >>$@
	@echo "    <offset>0x50000</offset>" >>$@
	@echo "  </part_info>" >>$@
	@echo "  <proj_info>" >>$@
	@$(foreach m,$(PRODUCT_MTK_RSC_NAMES),echo "    <proj_item index=\"$(MTK_RSC_XML_INDEX.$(m))\">" >>$@; echo "      <name>$(MTK_RSC_XML_NAME.$(m))</name>" >>$@; $(foreach n,$(MTK_RSC_XML_OPTR.$(m)),echo "      <operator>$(n)</operator>" >>$@;) echo "    </proj_item>" >>$@;)
	@echo "  </proj_info>" >>$@
	@echo "</runtime_switchable_config>" >>$@
LOCAL_PREBUILT_MODULE_FILE := $(intermediates)/gen.xml
ifeq (1,$(words $(PRODUCT_MTK_RSC_NAMES)))
LOCAL_MODULE_PATH := $(intermediates)/dummy
else
LOCAL_MODULE_PATH := $(TARGET_OUT)/$(PRODUCT_MTK_RSC_ROOT_PATH)
LOCAL_POST_INSTALL_CMD := cp -f $(intermediates)/gen.xml $(PRODUCT_OUT)/$(LOCAL_MODULE)
endif
include $(BUILD_PREBUILT)


PACKAGES.rsc.xml.OVERRIDES := $(mtk_rsc_override_modules)


include $(CLEAR_VARS)
LOCAL_MODULE := check-rsc-config
LOCAL_MODULE_CLASS := FAKE
LOCAL_ADDITIONAL_DEPENDENCIES += $(call local-intermediates-dir)/rsc.txt
# rule for rsc.txt is in device/mediatek/build/tasks/mtk_rsc.mk
include $(BUILD_PHONY_PACKAGE)
