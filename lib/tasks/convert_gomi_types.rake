namespace :convert_gomi_types do
  desc "TODO"
  task to_yaml: :environment do
    gomitype_path = Rails.root.join("db/gomitypenumber.csv")
    gomitype_body = File.read(gomitype_path)
    gomitype_csv  = CSV.parse(gomitype_body, headers: %i[type name])
    # gomitype_list = []

    # gomitype_csv.each { |row| gomitype_list << row.fields }

    fixture_path  = Rails.root.join("test/fixtures/gomi_types.yml")
    gomitype_yaml = YAML.dump(gomitype_csv.to_h)

    # File.write(fixture_path, gomitype_yaml)
  end

end
