# For DSBP
MTK_RSC_VENDOR_PROPERTIES += \
        ro.vendor.mtk_md_sbp_custom_value=0


# MAPC configuration file
ifneq ($(wildcard $(MTK_TARGET_PROJECT_FOLDER)/custom.conf),)
MTK_RSC_COPY_FILES += \
        $(MTK_TARGET_PROJECT_FOLDER)/custom.conf:SYSTEM:custom.conf
else
MTK_RSC_COPY_FILES += \
        device/mediatek/common/custom.conf:SYSTEM:custom.conf
endif

MTK_RSC_MODULES += Xunfei

MTK_RSC_XML_OPTR := NONE

MTK_RSC_APKS += MusicBspPlus:SYSTEM:app
MTK_RSC_APKS += SoundRecorder:SYSTEM:app
MTK_RSC_APKS += Stk1:SYSTEM:app
