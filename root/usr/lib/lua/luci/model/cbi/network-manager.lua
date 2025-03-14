m = Map("network-manager", translate("网络守护设置"), 
    translate("集成网络监测与定时维护功能"))

-- 基本设置
s = m:section(TypedSection, "basic", translate("基本配置"))
s.addremove = false
s.anonymous = true

o = s:option(Flag, "enabled", translate("启用服务"))
o.default = 0

o = s:option(ListValue, "interface", translate("目标接口"))
o:value("wan", "WAN")
o:value("wan6", "WAN6")
o.default = "wan"

o = s:option(Value, "time", translate("定时重启"))
o.placeholder = "03:30"
o.validate = function(self, value)
    if not value:match("^%d%d:%d%d$") then
        return nil, translate("时间格式必须为 HH:MM")
    end
    return value
end

-- 高级设置
s = m:section(TypedSection, "advanced", translate("高级配置"))
s.addremove = false
s.anonymous = true

o = s:option(Value, "ping_host", translate("检测主机"))
o.default = "8.8.8.8"
o.datatype = "host"

o = s:option(Value, "retry", translate("重试次数"))
o.default = 2
o.datatype = "range(1,5)"

return m