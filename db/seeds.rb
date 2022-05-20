gomitype_path = Rails.root.join("db/gomitypenumber.csv")
gomitype_body = File.read(gomitype_path, encoding: 'bom|utf-8')
gomitype_csv  = CSV.parse(gomitype_body, headers: true)

gomitype_csv.each { |row| GomiType.create(kind: row["記号"], name: row["ごみ種"]) }

areas = %w[
  中央区
  豊平区
  清田区
  北区
  東区
  白石区
  厚別区
  南区
  西区
  手稲区
]

areas.each { |name| Area.create(name: name) }

garvage_collection_path = Rails.root.join("db/2017100120191008garvagecollectioncalendar.csv")
garvage_collection_body = File.read(garvage_collection_path, encoding: 'bom|utf-8')
garvage_collection_csv  = CSV.parse(garvage_collection_body, headers: true)

row = garvage_collection_csv.first

collection_areas = row.headers[2..]
p collection_areas.size
collection_areas.each { |name| CollectionArea.create_by_area_name(name) }

# garvage_collection_path = Rails.root.join("db/garvagecollectioncalendar201910.csv")
# garvage_collection_path = Rails.root.join("db/garvagecollectioncalendar202010.csv")
# garvage_collection_path = Rails.root.join("db/garvagecollectioncalendar202110.csv")
