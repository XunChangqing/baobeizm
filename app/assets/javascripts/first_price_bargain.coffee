# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
title = "【巴黎春天】0元抢购iphone6s"
desc = "小伙伴们，救救我的肾，一起来为我砍价助力抢iphone6s"
imgUrl = "http://image.baobeizm.com/fpb/share.jpg"

try
  wx.config(
    debug: false
    appId: $appId
    timestamp: $timestamp
    nonceStr: $nonceStr
    signature: $signature
    jsApiList: ['showOptionMenu', 'onMenuShareTimeline', 'onMenuShareAppMessage'] )
  
  wx.ready ->
    try
      wx.showOptionMenu()
      wx.onMenuShareTimeline title: title, imgUrl: imgUrl, link: $share_url
      wx.onMenuShareAppMessage title: title, desc: desc, imgUrl: imgUrl, link: $share_url
    catch error

catch error
  #alert 'error'

$ ->
  $('.joiners-infinite-table').infinitePages
    debug: true
    loading: ->
      $(this).text('正在加载下一页...')
    error: ->
      $(this).button('发生错误，请稍后再试')
  $('.voters-infinite-table').infinitePages
    debug: true
    loading: ->
      $(this).text('正在加载下一页...')
    error: ->
      $(this).button('发生错误，请稍后再试')

#$ ->
  #$('#vote-link').click -> 
    #$.post '/first_price_bargain/vote.json', {openid: $('#vote-link').attr('openid')},
      #(data) -> 
        #$('#current-point').text data['point'] if data['point']
  ##alert 'click'
  

  #
#load images
$ ->
  #btnaup = new Image
  #btnaup.src = 'http://image.baobeizm.com/fpb/btnaup.png'
  #btnadown = new Image
  #btnadown.src = 'http://image.baobeizm.com/fpb/btnadown.png'
  #btnbup = new Image
  #btnbup.src = 'http://image.baobeizm.com/fpb/btnbup.png'
  #btnbdown = new Image
  #btnbdown.src = 'http://image.baobeizm.com/fpb/btnbdown.png'
  #btnsubmitup = new Image
  #btnsubmitup.src = 'http://image.baobeizm.com/fpb/btnsubmitup.png'
  #btnsubmitdown = new Image
  #btnsubmitdown.src = 'http://image.baobeizm.com/fpb/btnsubmitdown.png'
  backimg = new Image
  backimg.src = 'http://image.baobeizm.com/fpb/firstpriceback.jpg'
  backmainimg = new Image
  backmainimg.src = 'http://image.baobeizm.com/fpb/mainback.jpg'
  btnvoteup = new Image
  btnvoteup.src = 'http://image.baobeizm.com/fpb/btnvoteup.png'
  btnvotedown = new Image
  btnvotedown.src = 'http://image.baobeizm.com/fpb/btnvotedown.png'

  btninviteup = new Image
  btninviteup.src = 'http://image.baobeizm.com/fpb/btninviteup.png'
  btninvitedown = new Image
  btninvitedown.src = 'http://image.baobeizm.com/fpb/btninvitedown.png'

  btnjoinup = new Image
  btnjoinup.src = 'http://image.baobeizm.com/fpb/btnjoinup.png'
  btnjoindown = new Image
  btnjoindown.src = 'http://image.baobeizm.com/fpb/btnjoindown.png'

  btnselfup = new Image
  btnselfup.src = 'http://image.baobeizm.com/fpb/btnselfup.png'
  btnselfdown = new Image
  btnselfdown.src = 'http://image.baobeizm.com/fpb/btnselfdown.png'

  tab1img = new Image
  tab1img.src = 'http://image.baobeizm.com/fpb/tab1.jpg'
  tab2img = new Image
  tab2img.src = 'http://image.baobeizm.com/fpb/tab2.jpg'
  tab3img = new Image
  tab3img.src = 'http://image.baobeizm.com/fpb/tab3.jpg'
  
  refresh_list = ->
    #alert 'x'
    $('.joiners-infinite-table table tbody').html ''
    $('.joiners-infinite-table p').html '<a rel="next" data-remote="true" href="/first_price_bargain/show_joiners?page=1"></a>'
    $('.voters-infinite-table table tbody').html ''
    openid = $('.voters-infinite-table').attr('openid')
    #alert openid
    ohref = "/first_price_bargain/show_voters?page=1&openid=#{openid}"
    #alert ohref
    $('.voters-infinite-table p').html "<a rel='next' data-remote='true' href=#{ohref}></a>"
    #alert "<a rel="next" data-remote="true" href=#{ohref}></a>"
  refresh_list()

  t = $('.custom-btn').Touchable()
  t.on 'tap', ->
    #alert 'tap'
    tmpupimg = $(this).children('img').attr('src')
    #alert tmpupimg
    $(this).children('img').attr('src', $(this).attr('downimg'))
    $(this).delay('fast').queue(
      (next)->
        $(this).children('img').attr('src', tmpupimg)
        if $(this).attr('href')
          #alert $(this).attr('href')
          window.location.replace $(this).attr('href')
        else if $(this).attr('openid')
          #alert 'openid'
          $.post '/first_price_bargain/vote.json',
            {openid: $(this).attr('openid')},
            (data) ->
              if data['error']
                #alert data['error']
                alert "无法投票"
              if data['point']
                if data['point'] > 9999
                  p1val = p2val = p3val = p4val = '9'
                else
                  point = ('0000'+data['point']).slice(-4)
                  #alert point
                  p1val = point[0]
                  p2val = point[1]
                  p3val = point[2]
                  p4val = point[3]
                $('#p1').text(if point.length>4 then '9' else point[0] )
                $('#p2').text(if point.length>4 then '9' else point[1] )
                $('#p3').text(if point.length>4 then '9' else point[2] )
                $('#p4').text(if point.length>4 then '9' else point[3] )
                $('#friend-rank').text "好友排名:第#{data['rank']}位"
                #alert data['rank']
              votetag = $('#vote')
              votetag.attr('openid', null)
              votetag.attr('data-toggle', 'modal')
              votetag.attr('data-target', '#inviteModal')
              #votetag.children('h2').text '邀请好友'
              votetag.attr('downimg', 'http://image.baobeizm.com/fpb/btninvitedown.png')
              votetag.children('img').attr('src', 'http://image.baobeizm.com/fpb/btninviteup.png')
              $('#vote-success-modal').modal 'show'
              refresh_list()
              #location.reload()
        next()
    )

  $('#inviteModal').click ->
    $(this).modal 'hide'
  $('#close-vote-success').click ->
    #alert 'click hide'
    $('#vote-success-modal').modal 'hide'

  $('#close-join').click ->
    #alert 'click hide'
    $('#joinModal').modal 'hide'

  $('#join-form').submit ->
    if $('input#user-name').val().length<=0
      alert "请输入有效的姓名!"
      return false
    if not $('input#user-phone').val().match /[0-9]{11}/i
      alert "请输入有效的手机号码!"
      return false
    true

    #if not $('input#user-name').val().exist?
      #return false
    #phonenum = $('input#user-phone').val()
    #if phonenum.length <= 0
      #return false
    #true

  #$('.custom-btn').mousedown ->
    #$(this).children('img').attr('src', btnadown.src)
    #$(this).delay('fast').queue(
      #(next)->
        #$(this).children('img').attr('src', btnaup.src)
        #next()
    #)
  #$('.custom-btn').vmouseup ->
    #$(this).children('img').attr('src', btnaup.src)
$ ->
  $(".tablink").click ->
    $(this).tab('show')
    imgurl = $(this).attr('back')
    $('.custom-nav').css('background', "url('#{imgurl}')")

  
