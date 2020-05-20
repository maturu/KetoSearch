module ChartHelper
  require 'chunky_png'

  def qrcode_tag(url, options={})
    qr = ::RQRCode::QRCode.new(url)
    return ChunkyPNG::Image.from_datastream(qr.as_png.resize(300,300).to_datastream).to_data_url
  end
end
