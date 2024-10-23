require 'csv'

module CsvParser
    def self.parse(file_path)
      CSV.foreach(file_path, headers: true) do |row|
        building = Building.find_by(name: row['building name'])
        
        if building
          building.update(height: row['building height'].to_i)
        else
          Building.create(
            name: row['building name'],
            height: row['building height'].to_i
          )
        end
      end
    end
  end

# class CsvParser
#     REQUIRED_HEADERS = ['building name', 'building height']
  
#     def self.parse(file_path)
#       csv = CSV.read(file_path, headers: true)
      
#       # Validate headers
#       unless valid_headers?(csv.headers)
#         raise StandardError, "Invalid CSV format. Headers must be: #{REQUIRED_HEADERS.join(', ')}"
#       end
  
#       csv.each do |row|
#         name = row['building name']
#         height = row['building height']
  
#         # Validate each row
#         unless valid_row?(name, height)
#           raise StandardError, "Invalid data in row: #{row}"
#         end
  
#         Building.create!(name: name, height: height)
#       end
#     end
  
#     def self.valid_headers?(headers)
#       (REQUIRED_HEADERS - headers).empty?
#     end
  
#     def self.valid_row?(name, height)
#       name.present? && height.to_i > 0
#     end
#   end

  