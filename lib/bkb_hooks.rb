class BkbHooks < Spree::ThemeSupport::HookListener
  # custom hooks go here
  insert_after :admin_tabs do
  	%(<%= tab(:books) %> <%= tab(:book_clients)%>)
  end
end