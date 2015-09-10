<% if @voters %>
  $("<%=j render(:partial => 'voters', :object => @voters) %>")
    .appendTo($(".voters-infinite-table table tbody"))
<% end %>

<% if @voters==nil or @voters.last_page? %>
  $('.voters-pagination').html("")
  #$('.voters-pagination').html("没有记录了")
  #$('.voters-pagination').remove()
<% else %>
  $('.voters-pagination')
    .html("<%=j link_to '', {action: 'show_voters', remote: true, page: @voters.next_page}, {rel: 'next'} %>")
<% end %>

