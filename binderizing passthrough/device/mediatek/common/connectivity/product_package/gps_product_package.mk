# GPS Configuration
PRODUCT_PACKAGES += mnld
PRODUCT_PACKAGES += gps.default
PRODUCT_PACKAGES += flp.default

PRODUCT_PACKAGES += gps_drv.ko

ifeq ($(strip $(MTK_GPS_SUPPORT)), yes)
  DEVICE_MANIFEST_FILE += device/mediatek/common/project_manifest/manifest_gnss.xml
  ifneq ($(strip $(MTK_HIDL_PROCESS_CONSOLIDATION_ENABLED)), yes)
    PRODUCT_PACKAGES += vendor.mediatek.hardware.gnss@1.1-service
  endif
endif

# Always build LBS packages
PRODUCT_PACKAGES += LocationEM2 \
                  AutoDialer \
                  LPPeService \
                  NlpService

ifeq ($(strip $(MTK_AGPS_APP)), yes)
  PRODUCT_PACKAGES += mtk_agpsd \
                      cacerts_supl

  ifeq ($(strip $(RAT_CONFIG_C2K_SUPPORT)),yes)
    PRODUCT_PACKAGES += \
          libviagpsrpc \
          librpc
  endif
endif

ifndef MTK_AGPS_CONF_XML_SRC
  ifeq (OP12,$(word 1,$(subst _,$(space),$(OPTR_SPEC_SEG_DEF))))
    MTK_AGPS_CONF_XML_SRC := agps_profiles_conf2_OP12.xml
  else
    MTK_AGPS_CONF_XML_SRC := agps_profiles_conf2.xml
  endif
endif
PRODUCT_COPY_FILES += device/mediatek/common/agps/$(MTK_AGPS_CONF_XML_SRC):$(TARGET_COPY_OUT_VENDOR)/etc/agps_profiles_conf2.xml:mtk

# Mtk Nlp support
ifeq ($(strip $(MTK_NLP_SUPPORT)), yes)
  PRODUCT_PACKAGES += MtkNlp
endif

ifneq ($(strip $(MTK_HIDL_PROCESS_CONSOLIDATION_ENABLED)), yes)
  PRODUCT_PACKAGES += lbs_hidl_service
endif

# Add for Hardware Fused Location Related Modules
#ifneq ($(TARGET_BUILD_VARIANT), user)
#  ifneq ($(strip $(MTK_GMO_RAM_OPTIMIZE)), yes)
#    PRODUCT_PACKAGES += FlpEM2
#  endif
#endif

PRODUCT_PACKAGES += slpd
PRODUCT_COPY_FILES += device/mediatek/common/slp/slp_conf:$(TARGET_COPY_OUT_VENDOR)/etc/slp_conf:mtk

# GPS-PE offload to support Hardware Geofence and Fused Location
PRODUCT_PACKAGES += MNL.bin
PRODUCT_PACKAGES += lbs_dbg
