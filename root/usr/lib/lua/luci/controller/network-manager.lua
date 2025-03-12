module("luci.controller.network-manager", package.seeall)

function index()
    entry({"admin", "network", "network_manager"}, cbi("network-manager"), _("网络守护者"), 60)
end