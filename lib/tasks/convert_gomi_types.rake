namespace :convert_gomi_types do
  desc "TODO"
  task to_yaml: :environment do
    gomitype_path = Rails.root.join("db/gomitypenumber.csv")
    gomitype_body = File.read(gomitype_path)
    gomitype_csv  = CSV.parse(gomitype_body, headers: %i[type name])

    gomitype_csv.each do |row|
      p row[:type]
      p row[:name]
    end
  end

end
