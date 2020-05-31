module ChartHelper
  require 'chunky_png'

  def qrcode_tag(url, options={})
    qrcode = ::RQRCode::QRCode.new(url)
    qr_image = qrcode.as_png()
    logo = ChunkyPNG::Image.from_file('app/assets/images/qr_logo.png').resize(80,80)
    height = 175 - (logo.dimension.height / 2).floor
    width  = 175 - (logo.dimension.width  / 2).floor
    qr_composed = qr_image.resize(350, 350).compose!(logo, width, height)
    return ChunkyPNG::Image.from_datastream(qr_composed.to_datastream).to_data_url
  end
end
