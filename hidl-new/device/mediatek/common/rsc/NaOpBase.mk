# Rat config: 4M
MTK_RSC_VENDOR_PROPERTIES += \
    ro.vendor.mtk_protocol1_rat_config=Lf/Lt/W/G \
    ro.boot.opt_c2k_lte_mode=0

# Operator package properties: default OP08
MTK_RSC_VENDOR_PROPERTIES += \
        ro.vendor.operator.optr=OP08 \
        ro.vendor.operator.spec=SPEC0200 \
        ro.vendor.operator.seg=SEGDEFAULT \
        persist.vendor.operator.optr=OP08 \
        persist.vendor.operator.spec=SPEC0200 \
        persist.vendor.operator.seg=SEGDEFAULT

MTK_RSC_XML_OPTR := OP08_SPEC0200_SEGDEFAULT

# For DSBP
MTK_RSC_VENDOR_PROPERTIES += \
        ro.vendor.mtk_md_sbp_custom_value=8

# For CXP
MTK_RSC_VENDOR_PROPERTIES += \
	ro.vendor.mtk_carrierexpress_pack=na

MTK_RSC_APKS += \
	CarrierExpress:SYSTEM:priv-app

# For CXP-Switable NA Features, configured with PRODUCT_PROPERTY_OVERRIDES in device.mk
MTK_RSC_VENDOR_PROPERTIES += \
	persist.vendor.volte_support=1 \
	persist.vendor.mtk.volte.enable=1 \
	persist.vendor.mtk_wfc_support=1 \
	persist.vendor.mtk.wfc.enable=1 \
	persist.vendor.vilte_support=1 \
	persist.vendor.mtk.ims.video.enable=1 \
	persist.vendor.viwifi_support=1 \
	persist.vendor.mtk_rcs_ua_support=1

# For CXP-Switable NA features, configured with PRODUCT_SYSTEM_DEFAULT_PROPERTIES in device.mk

MTK_RSC_SYSTEM_PROPERTIES += \
	persist.vendor.mtk_uce_support=1 \
	persist.vendor.mtk_rcs_support=1 \
	persist.vendor.mtk_rtt_support=1 \
	persist.vendor.mdmi_support=1 \
	persist.vendor.vzw_device_type=3

# ----------------------------------------------------------------------------
# OP07 specific APK and Jar
# ----------------------------------------------------------------------------
MTK_RSC_APKS += \
	OP07cellbroadcastreceiver:SYSTEM:app \
    OP07Dialer:SYSTEM:app  \
    OP07TeleService:SYSTEM:app  \
	OP07Telecomm:SYSTEM:app  \
	OP07Contacts:SYSTEM:app  \
	OP07Browser:SYSTEM:app  \
	OP07Entitlement:SYSTEM:app  \
	OP07Settings:SYSTEM:app \
	OP07Wos:SYSTEM:app \
	OPTelecomCommon:SYSTEM:app \
	Op07Mms:SYSTEM:app

MTK_RSC_MODULES += \
    OP07Telephony \
	libeap-aka

# ----------------------------------------------------------------------------
# OP08 specific APK and Jar
# ----------------------------------------------------------------------------
MTK_RSC_APKS += \
    OP08Dialer:SYSTEM:app \
    OP08Contacts:SYSTEM:app \
    OP08Ims:SYSTEM:app \
    OP08Wos:SYSTEM:app \
    OP08cellbroadcastreceiver:SYSTEM:app \
    OP08TeleService:SYSTEM:app \
    OP08Settings:SYSTEM:app \
    OP08SystemUI:SYSTEM:app \
    OP08Telecom:SYSTEM:app

MTK_RSC_MODULES += OP08Telephony

# ----------------------------------------------------------------------------
# OP12 specific APK and Jar
# ----------------------------------------------------------------------------
MTK_RSC_APKS += \
    OP12TeleService:SYSTEM:app \
    OP12Settings:SYSTEM:app \
    OP12Dialer:SYSTEM:app \
    OP12Telecomm:SYSTEM:app \
    OP12Ims:SYSTEM:app \
    OP12CellbroadcastReceiver:SYSTEM:app

MTK_RSC_APKS += MdmiService:SYSTEM:app
MTK_RSC_MODULES += \
    libmdmi-core \
    libVzw_mdmi_debug \
    libVzw_mdmi_lte \
    libVzw_mdmi_gsm \
    libVzw_mdmi_umts \
    libVzw_mdmi_wifi \
    libVzw_mdmi_ims \
    libVzw_mdmi_commands \
    libVzw_mdmi_embms \
    libVzw_mdmi_wcdma \
    libVzw_mdmi_hsupa \
    libVzw_mdmi_hsdpa \
    capturepackets

MTK_RSC_MODULES += \
    OP12Telephony

# ----------------------------------------------------------------------------
# OP20 specific APK and Jar
# ----------------------------------------------------------------------------
MTK_RSC_APKS += \
    OP20SystemUI:SYSTEM:app \
    OP20TeleService:SYSTEM:app
