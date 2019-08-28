# Add common operator package properties
MTK_RSC_VENDOR_PROPERTIES += \
        ro.vendor.operator.optr=OP02 \
        ro.vendor.operator.spec=SPEC0200 \
        ro.vendor.operator.seg=SEGA \
        persist.vendor.operator.optr=OP02 \
        persist.vendor.operator.spec=SPEC0200 \
        persist.vendor.operator.seg=SEGA

# For rat config
MTK_RSC_VENDOR_PROPERTIES += ro.vendor.mtk_protocol1_rat_config=Lf/Lt/W/T/G

# For network property
MTK_RSC_SYSTEM_PROPERTIES += ro.telephony.default_network=9,9

# For SVLTE/SRLTE
MTK_RSC_VENDOR_PROPERTIES += ro.boot.opt_c2k_lte_mode=0

# For CT VoLTE
MTK_RSC_VENDOR_PROPERTIES += persist.vendor.mtk_ct_volte_support=0

# Set locale to simplified Chinese for China operator project
MTK_RSC_SYSTEM_PROPERTIES += persist.sys.locale=zh-Hans-CN

# MAPC configuration file
ifneq ($(wildcard $(MTK_TARGET_PROJECT_FOLDER)/custom.conf),)
MTK_RSC_COPY_FILES += \
        $(MTK_TARGET_PROJECT_FOLDER)/custom.conf:SYSTEM:custom.conf
else
MTK_RSC_COPY_FILES += \
        device/mediatek/common/custom.conf:SYSTEM:custom.conf
endif

#For DSBP
MTK_RSC_VENDOR_PROPERTIES += \
        ro.vendor.mtk_md_sbp_custom_value=0

MTK_RSC_MODULES += OP02Telephony

MTK_RSC_APKS += OP02Dialer:SYSTEM:app
MTK_RSC_APKS += OP02TeleService:SYSTEM:app
MTK_RSC_APKS += OP02Settings:SYSTEM:app
MTK_RSC_APKS += OP02SystemUI:SYSTEM:app
MTK_RSC_APKS += MusicBspPlus:SYSTEM:app
MTK_RSC_APKS += SoundRecorder:SYSTEM:app
MTK_RSC_APKS += OP02Mms:SYSTEM:app
MTK_RSC_APKS += OP02Stk:SYSTEM:app
MTK_RSC_APKS += OP02StkOverlay:SYSTEM:overlay

MTK_RSC_MODULES += Xunfei

MTK_RSC_MODULES += mtkbootanimation
MTK_RSC_MODULES += libmtkbootanimation

MTK_RSC_XML_OPTR := OP02_SPEC0200_SEGA

