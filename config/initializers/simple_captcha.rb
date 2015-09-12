SimpleCaptcha.setup do |sc|
  # default: 100x28
  #sc.image_size = '120x40'

  # default: 5
  sc.length = 3

  # default: simply_blue
  # possible values:
  # 'embosed_silver',
  # 'simply_red',
  # 'simply_green',
  # 'simply_blue',
  # 'distorted_black',
  # 'all_black',
  # 'charcoal_grey',
  # 'almost_invisible'
  # 'random'
  #sc.image_style = 'simply_red'
  sc.image_style = 'mycaptha'
  sc.add_image_style('mycaptha', [
    "-background '#E12727'",
    "-fill '#FDF927'"])

  # default: low
  # possible values: 'low', 'medium', 'high', 'random'
  sc.distortion = 'low'

  # default: medium
  # possible values: 'none', 'low', 'medium', 'high'
  sc.implode = 'low'
end
