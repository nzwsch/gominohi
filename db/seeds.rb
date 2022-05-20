gomitype_path = Rails.root.join("db/gomitypenumber.csv")
gomitype_body = File.read(gomitype_path, encoding: 'bom|utf-8')
gomitype_csv  = CSV.parse(gomitype_body, headers: true)

gomitype_csv.each do |row|
  GomiType.create(kind: row["記号"], name: row["ごみ種"])
end
