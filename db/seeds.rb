require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'dataset.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each_with_index do |row, index|
  food = Food.create!(
    gram: 100,
    tag: row['TAG'],
    name: row['NAME'],
    calorie: row['CALORIE'],
    water: row['WATER'],
    protain: row['PROTAIN'],
    lipid: row['LIPID'],
    carbohydrate: row['CARBOHYDRATE'],
    fibtg: row['FIBTG'],
    na: row['NA'],
    user_id: 1
  )
end
