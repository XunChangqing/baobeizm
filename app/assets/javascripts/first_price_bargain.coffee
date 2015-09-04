# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
wx.config(
  debug: false
  appId: $appId
  timestamp: $timestamp
  nonceStr: $nonceStr
  signature: $signature
  jsApiList: ['showOptionMenu'] )
wx.ready( wx.showOptionMenu())
