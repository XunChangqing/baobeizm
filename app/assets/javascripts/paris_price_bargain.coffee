# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

totalpeople = 1000
progressbar_width = 950
#bagnums = [50, 100, 150, 200, 250, 300]
bagnums = [50, 100, 150, 200, 300]
bagthds = [100, 300, 500, 800, 1000]
personnums = [0,100,300,500,800,1000]

worker = ->
  $.post '/paris_price_bargain/vote.json',
    {update: 1},
    (data) ->
      refresh(data['count'])
      setTimeout worker, 5000

refresh = (progress)->
  $('#count').text "#{progress}人"
  ratio = progress / totalpeople
  p = Math.floor(ratio * 100) + '%'
  $('#progressbar').css('width', p)
  left = (ratio*progressbar_width-80/2) + 'px'
  $('#shield').css('left', left)

  bagimgs = ($("#bag-#{num}") for num in bagnums)
  personimgs = ($("#person-#{num}") for num in personnums)
  #bags
  for money, i in bagnums
    imgname = "/image/parispb/bag-#{money}"
    if bagthds[i]>progress
      bagimgs[i].attr('src', "#{imgname}-todo.png")
    else if bagthds[i+1]>progress
      bagimgs[i].attr('src', "#{imgname}-doing.png")
      bagimgs[i].css('height', '150px')
      bagimgs[i].css('width', '150px')
    else
      bagimgs[i].attr('src', "#{imgname}-done.png")

  ##people
  #for num i in personnums
    #if num<=progress
      #personimgs[i].attr('src', "/image/parispb/people-#{num}-gray.png")
    #else
      #personimgs[i].attr('src', "/image/parispb/people-#{num}-highlight.png")

$ ->
  try
    refresh 999
    $('#vote-form').submit ->
      if $('input#user-name').val().length<=0
        alert "请输入有效的姓名!"
        return false
      if not $('input#user-phone').val().match /[0-9]{11}/i
        alert "请输入有效的手机号码!"
        return false
      $.post $(this).attr('action'), $(this).serialize(), (data)->
        refresh data['count']
      false
  catch error
    alert error


