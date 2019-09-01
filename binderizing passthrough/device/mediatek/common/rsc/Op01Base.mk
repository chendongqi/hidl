# Add common operator package properties
MTK_RSC_VENDOR_PROPERTIES += \
        ro.vendor.operator.optr=OP01 \
        ro.vendor.operator.spec=SPEC0200 \
        ro.vendor.operator.seg=SEGC \
        persist.vendor.operator.optr=OP01 \
        persist.vendor.operator.spec=SPEC0200 \
        persist.vendor.operator.seg=SEGC

# For CT VoLTE
MTK_RSC_VENDOR_PROPERTIES += persist.vendor.mtk_ct_volte_support=0

# Set locale to simplified Chinese for China operator project
MTK_RSC_SYSTEM_PROPERTIES += persist.sys.locale=zh-Hans-CN

#For DSBP
MTK_RSC_VENDOR_PROPERTIES += \
        persist.vendor.radio.mtk_dsbp_support=0 \
        ro.vendor.mtk_md_sbp_custom_value=1

# MAPC configuration file
ifneq ($(wildcard $(MTK_TARGET_PROJECT_FOLDER)/custom.conf),)
MTK_RSC_COPY_FILES += \
        $(MTK_TARGET_PROJECT_FOLDER)/custom.conf:SYSTEM:custom.conf
else ifneq ($(wildcard vendor/mediatek/proprietary/operator/SPEC/OP01/SPEC0200/SEGC/custom.conf),)
MTK_RSC_COPY_FILES += \
        vendor/mediatek/proprietary/operator/SPEC/OP01/SPEC0200/SEGC/custom.conf:SYSTEM:custom.conf
else
MTK_RSC_COPY_FILES += \
        device/mediatek/common/custom.conf:SYSTEM:custom.conf
endif

MTK_RSC_MODULES += Xunfei

MTK_RSC_MODULES += OP01Telephony

ifneq ($(wildcard vendor/mediatek/proprietary/operator/packages/apps/TxtViewer),)
MTK_RSC_APKS += TXTViewer:VENDOR:app
endif

MTK_RSC_APKS += OP01Dialer:SYSTEM:app
MTK_RSC_APKS += Op01Contacts:SYSTEM:app
MTK_RSC_APKS += OP01Telecom:SYSTEM:app
MTK_RSC_APKS += OP01TeleService:SYSTEM:app
MTK_RSC_APKS += OP01Mms:SYSTEM:app
MTK_RSC_APKS += OP01Email:SYSTEM:app
MTK_RSC_APKS += OP01Settings:SYSTEM:app
MTK_RSC_APKS += OP01SystemUI:SYSTEM:app
MTK_RSC_APKS += OP01Music:SYSTEM:app
MTK_RSC_APKS += OP01SoundRecorder:SYSTEM:app
MTK_RSC_APKS += Op01WifiService:SYSTEM:app
MTK_RSC_APKS += UsbChecker:SYSTEM:app

MTK_RSC_APKS += Stk1:SYSTEM:app

MTK_RSC_XML_OPTR := OP01_SPEC0200_SEGC

