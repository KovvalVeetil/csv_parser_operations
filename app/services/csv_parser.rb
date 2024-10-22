require 'csv'

module CsvParser
    def self.parse(file_path)
        CSV.foreach(file_path, headers: true) do |row|
            Building.create(
                name: row['building name'],
                height: row['building height'].to_i
            )
        end
    end
end