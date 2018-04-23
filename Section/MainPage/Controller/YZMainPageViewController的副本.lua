//lua代码
waxClass{"AViewController"}
function showHotFix(self)
local ceshiview = UIAlertView:initWithTitle_message_delegate_cancelButtonTitle_otherButtonTitles("HotFix","测试HotFix修复后的detail是否改变",nil,"OK ",nil)
ceshiview:show()
end