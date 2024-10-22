class BuildingsController < ApplicationController
    def new
    end

    def upload_csv
        if params[:file].present?
            file_path = params[:file].path

            if File.exist?(file_path)
                CsvParser.parse(file_path)
                redirect_to buildings_path, notice: 'CSV uploaded and parsed successfully'
            else
                redirect_to new_building_path, alert: 'Uploaded file does not exist.'
            end
        else
            redirect_to new_building_path, alert: 'No file uploaded.'
        end
    end

    def index
        @buildings = Building.all
    end
end
