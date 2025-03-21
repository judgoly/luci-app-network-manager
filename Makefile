include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-network-manager
PKG_VERSION:=1.6
PKG_RELEASE:=1

PKG_MAINTAINER:=Your Name <your@email.com>
PKG_LICENSE:=MIT

PKG_CONFIG_DEPENDS:= \
	CONFIG_PACKAGE_$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=Network Interface Manager
	DEPENDS:=+luci-base +luci-compat
	PKGARCH:=all
endef

define Package/$(PKG_NAME)/description
	Advanced network interface management with scheduled reboot and monitoring.
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
	
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./root/usr/bin/network-check $(1)/usr/bin/
	
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) ./root/usr/sbin/scheduled-reboot $(1)/usr/sbin/
	
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./root/etc/init.d/netwatch $(1)/etc/init.d/
	$(INSTALL_BIN) ./root/etc/init.d/scheduler $(1)/etc/init.d/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci
	cp -r ./root/usr/lib/lua/luci/* $(1)/usr/lib/lua/luci/
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
# 启用服务自启
/etc/init.d/netwatch enable >/dev/null 2>&1
/etc/init.d/scheduler enable >/dev/null 2>&1
exit 0
endef

$(eval $(call BuildPackage,$(PKG_NAME)))