require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'dataset.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each_with_index do |row, index|
  food = Food.find_by(name: row['NAME']).update!(
    na: row['NA']
  )
end
