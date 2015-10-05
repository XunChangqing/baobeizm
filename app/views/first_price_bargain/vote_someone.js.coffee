#alert yes
#alert "<%= @voter.openid%>"
<% if @timeout %>
  alert "活动已经结束，无法投票"
<% else %>
  $("#<%= @voter.openid%>").html("")
<% end %>

