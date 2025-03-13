m = Map("network-manager", translate("网络接口守护设置"), 
    translate("用于管理网络接口的定时重启和监控"))

-- 基本设置
s = m:section(TypedSection, "basic", translate("基本设置"), 
    translate("基础网络守护配置"))
s.addremove = false  -- 禁止动态添加/删除配置节
s.anonymous = true   -- 隐藏配置节名称显示

o = s:option(Flag, "enabled", translate("启用服务"))
o.default = 0

o = s:option(ListValue, "interface", translate("目标接口"))
o:value("wan", "WAN")
o:value("wan6", "WAN6")
o.default = "wan"

o = s:option(Value, "time", translate("每日重启时间"))
o.datatype = "timehhmm"
o.placeholder = "03:30"

-- 高级设置
s = m:section(TypedSection, "advanced", translate("高级设置"),
    translate("高级网络检测参数"))
s.addremove = false
s.anonymous = true

o = s:option(Value, "ping_host", translate("检测主机"))
o.default = "8.8.8.8"
o.datatype = "host"

o = s:option(Value, "retry", translate("重试次数"))
o.default = 3
o.datatype = "uinteger"

return m