gomitype_path = Rails.root.join("db/gomitypenumber.csv")
gomitype_body = File.read(gomitype_path, encoding: 'bom|utf-8')
gomitype_csv  = CSV.parse(gomitype_body, headers: true)

gomitype_csv.each do |row|
  if row["記号"].to_i > 0
    GomiType.create(
      id: row["記号"],
      name: row["ごみ種"],
    )
  end
end

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
original_collection_areas = collection_areas.size
collection_areas.each { |name| CollectionArea.create_by_area_name(name) }

collection_dates = []

garvage_collection_csv.each do |row|
  date    = row[0]
  weekday = row[1]

  row.headers[2..].each_with_index do |name, index|
    gomi_type_id = row[2 + index]

    next if gomi_type_id.to_i == 0

    collection_dates.push({
      date: date,
      weekday: weekday,
      name: name,
      gomi_type_id: gomi_type_id
    })
  end
end

grouped_dates = collection_dates.group_by { |item| item[:name] }

grouped_dates.each do |name, collection_dates|
  collection_area_id = CollectionArea.find_by_name(name).id
  collection_dates   = collection_dates.map do |item|
    {
      date: item[:date],
      weekday: item[:weekday],
      collection_area_id: collection_area_id,
      gomi_type_id: item[:gomi_type_id],
      created_at: Time.current,
      updated_at: Time.current,
    }
  end

  CollectionDate.insert_all(collection_dates)
end

garvage_collection_path = Rails.root.join("db/garvagecollectioncalendar201910.csv")
garvage_collection_body = File.read(garvage_collection_path, encoding: 'bom|utf-8')
garvage_collection_csv  = CSV.parse(garvage_collection_body, headers: true)

row = garvage_collection_csv.first

collection_areas = row.headers[2..]
warn "[!] collection_areas has changed" if collection_areas.size != original_collection_areas

collection_dates = []

garvage_collection_csv.each do |row|
  date    = row[0]
  weekday = row[1]

  row.headers[2..].each_with_index do |name, index|
    gomi_type_id = row[2 + index]

    next if gomi_type_id.to_i == 0

    collection_dates.push({
      date: date,
      weekday: weekday,
      name: name,
      gomi_type_id: gomi_type_id
    })
  end
end

grouped_dates = collection_dates.group_by { |item| item[:name] }

grouped_dates.each do |name, collection_dates|
  collection_area_id = CollectionArea.find_by_name(name).id
  collection_dates   = collection_dates.map do |item|
    {
      date: item[:date],
      weekday: item[:weekday],
      collection_area_id: collection_area_id,
      gomi_type_id: item[:gomi_type_id],
      created_at: Time.current,
      updated_at: Time.current,
    }
  end

  CollectionDate.insert_all(collection_dates)
end

# garvage_collection_path = Rails.root.join("db/garvagecollectioncalendar202010.csv")
# garvage_collection_path = Rails.root.join("db/garvagecollectioncalendar202110.csv")
