# frozen_string_literal: true

gomitype_path = Rails.root.join('db/gomitypenumber.csv')
gomitype_body = File.read(gomitype_path, encoding: 'bom|utf-8')
gomitype_csv  = CSV.parse(gomitype_body, headers: true)

gomitype_csv.each do |row|
  next if row['記号'].to_i.zero?

  GomiType.create(
    id: row['記号'],
    name: row['ごみ種']
  )
end

# Import csv
module SeedTask
  AREAS = %w[
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
  ].freeze

  class CsvImporter
    def initialize(csv_file_path)
      csv_path = Rails.root.join(csv_file_path)
      csv_body = File.read(csv_path, encoding: 'bom|utf-8')
      @csv_data = CSV.parse(csv_body, headers: true)
    end

    def collection_areas
      @csv_data.first.headers[2..]
    end

    # C: Metrics/MethodLength: Method has too many lines. [15/10]
    def import!
      grouped_dates = filter_collection_dates.group_by { |item| item[:name] }

      grouped_dates.each do |name, collection_dates|
        collection_area_id = CollectionArea.find_by_name(name).id
        collection_dates   = collection_dates.map do |item|
          {
            date: item[:date],
            weekday: item[:weekday],
            collection_area_id: collection_area_id,
            gomi_type_id: item[:gomi_type_id],
            created_at: Time.current,
            updated_at: Time.current
          }
        end

        CollectionDate.insert_all(collection_dates)
      end
    end

    private

    # C: Metrics/MethodLength: Method has too many lines. [16/10]
    def filter_collection_dates
      collection_dates = []

      @csv_data.each do |row|
        date    = row[0]
        weekday = row[1]

        row.headers[2..].each_with_index do |name, index|
          gomi_type_id = row[2 + index]

          next if gomi_type_id.to_i.zero?

          collection_dates.push(
            date: date,
            weekday: weekday,
            name: replace_special_numbers(name),
            gomi_type_id: gomi_type_id
          )
        end
      end

      collection_dates
    end

    def replace_special_numbers(name)
      name
        .gsub('①', '1')
        .gsub('②', '2')
        .gsub('③', '3')
        .gsub('④', '4')
        .gsub('⑤', '5')
        .gsub('⑥', '6')
        .gsub('⑦', '7')
    end
  end
end

SeedTask::AREAS.each { |name| Area.create(name: name) }

csv_importer = SeedTask::CsvImporter.new('db/2017100120191008garvagecollectioncalendar.csv')

collection_areas = csv_importer.collection_areas
original_size = collection_areas.size
collection_areas.each { |name| CollectionArea.create_by_area_name(name) }

csv_importer.import!

csv_importer = SeedTask::CsvImporter.new('db/garvagecollectioncalendar201910.csv')

current_size = csv_importer.collection_areas.size
warn '[!] collection_areas has changed' if current_size != original_size

csv_importer.import!

csv_importer = SeedTask::CsvImporter.new('db/garvagecollectioncalendar202010.csv')

current_size = csv_importer.collection_areas.size
warn '[!] collection_areas has changed' if current_size != original_size

csv_importer.import!

csv_importer = SeedTask::CsvImporter.new('db/garvagecollectioncalendar202110.csv')

current_size = csv_importer.collection_areas.size
warn '[!] collection_areas has changed' if current_size != original_size

csv_importer.import!
