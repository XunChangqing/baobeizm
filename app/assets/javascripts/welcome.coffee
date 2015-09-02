wx.config(
  debug: true
  appId: $appId
  timestamp: $timestamp
  nonceStr: $nonceStr
  signature: $signature
  jsApiList: ['showOptionMenu'] )
wx.ready( wx.showOptionMenu())
#wx.error(-> alert('no'))
#wx.error(-> alert('no'))
#alert('hello')
