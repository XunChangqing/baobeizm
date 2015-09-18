# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

totalpeople = 1000
#progressbar_width = 920
progressbar_width = 0.92
#bagnums = [50, 100, 150, 200, 250, 300]
bagnums = [50, 100, 150, 200, 300]
bagthds = [100, 300, 500, 800, 1000]
personnums = [100,300,500,800,1000]

worker = ->
  $.post '/paris_price_bargain/vote.json',
    {update: 1},
    (data) ->
      #alert data['count']
      refresh(data['count'])
      setTimeout worker, 10000

refresh = (progress)->
  $('#count').text "#{progress}人"
  ratio = progress / totalpeople
  p = Math.floor(ratio * 100) + '%'
  $('#progressbar').css('width', p)
  left = (ratio*progressbar_width-0.08/2)*100 + '%'
  $('#shield').css('left', left)

  bagimgs = ($("#bag-#{num}") for num in bagnums)
  personimgs = ($("#people-#{num}") for num in personnums)
  #bags
  for money, i in bagnums
    imgname = "http://image.baobeizm.com/parispb/bag-#{money}"
    if bagthds[i]>progress
      bagimgs[i].attr('src', "#{imgname}-todo.png")
      bagimgs[i].css('height', '18.3%')
      bagimgs[i].css('width', '10%')
    else if bagthds[i+1]>progress
      bagimgs[i].attr('src', "#{imgname}-doing.png")
      bagimgs[i].css('height', '21.9%')
      bagimgs[i].css('width', '12%')
    else
      bagimgs[i].attr('src', "#{imgname}-done.png")
      bagimgs[i].css('height', '18.3%')
      bagimgs[i].css('width', '10%')

  ##people
  for num, i in personnums
    imgname = "http://image.baobeizm.com/parispb/people-#{num}"
    if num<=progress and personnums[i+1]>progress
      personimgs[i].attr('src', "#{imgname}-on.png")
      personimgs[i].css('width', '11.8%')
      personimgs[i].css('height', '12.8%')
    else if num==1000 and progress>=1000 
      personimgs[i].attr('src', "#{imgname}-on.png")
      personimgs[i].css('width', '11.8%')
      personimgs[i].css('height', '12.8%')
    else
      personimgs[i].attr('src', "#{imgname}-off.png")
      personimgs[i].css('width', '8%')
      personimgs[i].css('height', '8.2%')

$ ->
  try
    if $('#validate').attr('val') == 'yes'
      worker()
    #refresh 100
    $('#vote-form').submit ->
      if $('input#user-name').val().length<=0
        alert "请输入有效的姓名!"
        return false
      if not $('input#user-phone').val().match /[0-9]{11}/i
        alert "请输入有效的手机号码!"
        return false
      $.post $(this).attr('action'), $(this).serialize(), (data)->
        refresh data['count']
        alert '砍价成功'
      false
  catch error
    alert error


