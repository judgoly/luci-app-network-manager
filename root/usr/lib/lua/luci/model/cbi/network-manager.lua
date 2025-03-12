m = Map("network-manager", translate("网络接口守护设置"))

s = m:section(TypedSection, "basic", translate("基本设置"))
s.addremove = false

o = s:option(Flag, "enabled", translate("启用服务"))
o.default = 0

o = s:option(ListValue, "interface", translate("目标接口"))
o:value("wan", "WAN")
o:value("wan6", "WAN6")
o.default = "wan"

o = s:option(Value, "time", translate("每日重启时间"))
o.datatype = "timehhmm"
o.placeholder = "03:30"

s = m:section(TypedSection, "advanced", translate("高级设置"))
s.addremove = false

o = s:option(Value, "ping_host", translate("检测主机"))
o.default = "8.8.8.8"
o.datatype = "host"

o = s:option(Value, "retry", translate("重试次数"))
o.default = 3
o.datatype = "uinteger"

return m