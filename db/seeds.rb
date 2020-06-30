require 'csv'

admin = User.find_by(admin: true)

#csv_text = File.read(Rails.root.join('lib', 'seeds', 'dataset.csv'))
#csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
#csv.each_with_index do |row, index|
#  Food.find_by(name: row['NAME']).destroy
#end

csv_text = File.read(Rails.root.join('lib', 'seeds', 'dataset_v2.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each_with_index do |row, index|
  Food.find_by(name: row['NAME']).update!(
    fibtg: row['FIBTG']
  )
  #food = Food.create!(
  #  gram: 100,
  #  tag: row['TAG'],
  #  name: row['NAME'],
  #  calorie: row['CALORIE'],
  #  water: row['WATER'],
  #  protain: row['PROTAIN'],
  #  lipid: row['LIPID'],
  #  carbohydrate: row['CARBOHYDRATE'],
  #  fibtg: row['FIBTG'],
  #  na: row['NA'],
  #  store_id: admin.store.id,
  #  price: 0,
  #  reference: "日本食品標準成分表2015年版（七訂）",
  #  url: "https://www.mext.go.jp/a_menu/syokuhinseibun/1365297.htm",
  #  review_permit: false
  #)
end
