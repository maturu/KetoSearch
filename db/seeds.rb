require 'csv'

user = User.all.first

csv_text = File.read(Rails.root.join('lib', 'seeds', 'dataset.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each_with_index do |row, index|
  food = Food.create!(
    tag: row['TAG'],
    name: row['NAME'],
    gram: "100",
    calorie: row['CALORIE'],
    water: row['WATER'],
    protain: row['PROTAIN'],
    lipid: row['LIPID'],
    carbohydrate: row['CARBOHYDRATE'],
    fibtg: row['FIBTG'],
    content: "",
    reference: "日本食品標準成分表2015年版(七訂)",
    url: "http://www.mext.go.jp/a_menu/syokuhinseibun/1365297.htm",
    protect: true,
    user_id: user.id
  )
  History.create!(
    user_id: user.id,
    food_id: food.id,
    name: row['NAME']
  )
end
