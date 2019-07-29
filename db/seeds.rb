# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

DATA_FILE = "./db/data.csv"

include ReadCsv
  values = read_csv(DATA_FILE)

  sql_insert_columns = values[0].join(', ')
  sql_insert_values =
  values[1..-1]
  .map do |array|
    array[0] = "'#{array[0]}'"
    array.join(', ')
  end
  .join('), (')


sql = "INSERT INTO items (#{sql_insert_columns}) VALUES (#{sql_insert_values})"

ApplicationRecord.connection.execute(sql);
