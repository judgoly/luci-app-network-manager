include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-network-manager
PKG_VERSION:=1.5
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=Network Manager with Argon UI
  DEPENDS:=+luci-base +luci-compat
  PKGARCH:=all
endef

define Build/Prepare
	@echo "Copying local files to build directory..."
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./root/* $(PKG_BUILD_DIR)/
endef

define Package/$(PKG_NAME)/install
	# 配置文件
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/etc/config/network-manager $(1)/etc/config/
	
	# 可执行文件
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/usr/bin/network-check $(1)/usr/bin/
	
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/usr/sbin/scheduled-reboot $(1)/usr/sbin/
	
	# 服务脚本
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/etc/init.d/netwatch $(1)/etc/init.d/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/etc/init.d/scheduler $(1)/etc/init.d/
	
	# LuCI组件
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci
	cp -r $(PKG_BUILD_DIR)/usr/lib/lua/luci/* $(1)/usr/lib/lua/luci/
endef

define Package/$(PKG_NAME)/postinst
	#!/bin/sh
	/etc/init.d/netwatch enable >/dev/null 2>&1
	/etc/init.d/scheduler enable >/dev/null 2>&1
	exit 0
endef

$(eval $(call BuildPackage,$(PKG_NAME)))