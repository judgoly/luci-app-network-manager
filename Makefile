include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-network-manager
PKG_VERSION:=1.1
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=Network Interface Manager with Argon UI
  DEPENDS:=+luci-base +luci-compat
  PKGARCH:=all
endef

define Package/$(PKG_NAME)/description
  A network interface management tool with scheduled restart and monitoring features.
endef

define Build/Prepare
	@echo "跳过准备阶段"
endef

define Build/Configure
	@echo "跳过配置阶段"
endef

define Build/Compile
	@echo "跳过编译阶段"
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./root/etc/config/network-manager $(1)/etc/config/network-manager
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./root/usr/lib/lua/luci/controller/network-manager.lua $(1)/usr/lib/lua/luci/controller/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DATA) ./root/usr/lib/lua/luci/model/cbi/network-manager.lua $(1)/usr/lib/lua/luci/model/cbi/
	
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./root/usr/bin/network-check $(1)/usr/bin/
	
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./root/etc/init.d/netwatch $(1)/etc/init.d/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))