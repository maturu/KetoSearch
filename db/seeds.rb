require 'csv'

#csv_text = File.read(Rails.root.join('lib', 'seeds', 'price.csv'))
#csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
#csv.each do |row|
#  price = Price.create!(
#    price_id: row['PRICE_ID'],
#    name: row['NAME'],
#    twenty_nineteen_feb: row['2019-02'],
#    twenty_nineteen_mar: row['2019-03'],
#    twenty_nineteen_apr: row['2019-04'],
#    twenty_nineteen_may: row['2019-05'],
#    twenty_nineteen_jun: row['2019-06'],
#    twenty_nineteen_jul: row['2019-07'],
#    twenty_nineteen_aug: row['2019-08'],
#    twenty_nineteen_sep: row['2019-09'],
#    twenty_nineteen_oct: row['2019-10'],
#    twenty_nineteen_nov: row['2019-11'],
#    twenty_nineteen_dec: row['2019-12'],
#    twenty_twenty_jan: row['2020-01'],
#    twenty_twenty_feb: row['2020-02']
#  )
#end

csv_text = File.read(Rails.root.join('lib', 'seeds', 'dataset.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  food = Food.create!(
    category: row['CATEGORY'],
    price_id: row['PRICE_ID'],
    tag: row['TAG'],
    name: row['NAME'],
    calorie: row['CALORIE'],
    water: row['WATER'],
    protain: row['PROTAIN'],
    lipid: row['LIPID'],
    carbohydrate: row['CARBOHYDRATE']
  )
end
