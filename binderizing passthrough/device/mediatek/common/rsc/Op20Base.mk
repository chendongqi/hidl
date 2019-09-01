# Rat config: 5M
MTK_RSC_VENDOR_PROPERTIES += \
	ro.vendor.mtk_protocol1_rat_config=C/Lf/Lt/W/G \
	ro.boot.opt_c2k_lte_mode=2

# Operator package properties: OP20
MTK_RSC_VENDOR_PROPERTIES += \
        ro.vendor.operator.optr=OP20 \
        ro.vendor.operator.spec=SPEC0200 \
        ro.vendor.operator.seg=SEGDEFAULT \
        persist.vendor.operator.optr=OP20 \
        persist.vendor.operator.spec=SPEC0200 \
        persist.vendor.operator.seg=SEGDEFAULT

MTK_RSC_XML_OPTR := OP20_SPEC0200_SEGDEFAULT

# For DSBP
MTK_RSC_VENDOR_PROPERTIES += \
        persist.vendor.radio.mtk_dsbp_support=0 \
        ro.vendor.mtk_md_sbp_custom_value=20

# For CXP
MTK_RSC_VENDOR_PROPERTIES += \
	ro.vendor.mtk_carrierexpress_pack=no

# For CXP-Switable NA Features, configured with PRODUCT_PROPERTY_OVERRIDES in device.mk
MTK_RSC_VENDOR_PROPERTIES += \
	persist.vendor.volte_support=1 \
	persist.vendor.mtk.volte.enable=1 \
	persist.vendor.mtk_wfc_support=1 \
	persist.vendor.mtk.wfc.enable=1 \
	persist.vendor.vilte_support=0 \
	persist.vendor.mtk.ims.video.enable=0 \
	persist.vendor.viwifi_support=0 \
	persist.vendor.mtk_rcs_ua_support=0

# For CXP-Switable NA features, configured with PRODUCT_SYSTEM_DEFAULT_PROPERTIES in device.mk
MTK_RSC_SYSTEM_PROPERTIES += \
	persist.vendor.mtk_uce_support=0 \
	persist.vendor.mtk_rcs_support=0 \
	persist.vendor.mtk_rtt_support=0 \
	persist.vendor.mdmi_support=0 \
	persist.vendor.vzw_device_type=0

# ----------------------------------------------------------------------------
# OP20 specific APK and Jar
# ----------------------------------------------------------------------------
MTK_RSC_APKS += \
	OP20SystemUI:SYSTEM:app \
	OP20TeleService:SYSTEM:app
