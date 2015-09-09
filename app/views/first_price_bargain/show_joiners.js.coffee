<% if @joiners %>
  $("<%=j render(:partial => 'joiners', :object => @joiners,  locals: {page_offset: @page_offset}) %>")
    .appendTo($(".joiners-infinite-table table tbody"))
<% end %>

<% if @joiners==nil or @joiners.last_page? %>
  $('.joiners-pagination').html("没有记录了")
<% else %>
  $('.joiners-pagination')
    .html("<%=j link_to '', {action: 'show_joiners', remote: true, page: @joiners.next_page}, {rel: 'next'} %>")
<% end %>

