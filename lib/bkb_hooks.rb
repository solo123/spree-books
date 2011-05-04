#encoding: utf-8
class BkbHooks < Spree::ThemeSupport::HookListener
  # custom hooks go here
  insert_after :admin_tabs do
  	%(<%= tab(:books) %> <%= tab(:book_clients)%>)
  end
  
  insert_after :admin_configurations_menu do
  	'<tr><td><a href="/admin/book_configuration">Reader配置</a></td><td>配置手机书城软件移动基地等参数</td></tr>'
  end
  
  insert_before :account_summary do
  	'<p><a href="/channel/balances">查看清单</a></p>'
  end
end
