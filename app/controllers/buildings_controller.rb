require 'csv'

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
        @buildings = filter_buildings(@buildings)
        @buildings = sort_buildings(@buildings)

        @buildings = @buildings.page(params[:page]).per(5)

        Rails.logger.debug "Final Buildings Query: #{@buildings.to_sql}"
    end

    def edit
        @building = Building.find(params[:id])
    end

    def update
        @building = Building.find(params[:id])
        if @building.update(building_params)
            redirect_to buildings_path, notice: 'Building was sucessfully updated'
        else
            puts @building.errors.full_messages
            render :edit
        end
    end

    def destroy
        @building = Building.find(params[:id])
        @building.destroy
        redirect_to buildings_path, notice: 'Building was successfully deleted.'
    end

    def export
        @buildings = Building.all

        respond_to do |format|
            format.csv { send_data generate_csv(@buildings), filename: "buildings-#{Date.today}.csv" }
        end
    end

    private

    def building_params
        params.require(:building).permit(:name, :height)
    end

    def filter_buildings(buildings)
        if params[:search].present?
            buildings = buildings.where("name LIKE ?", "%#{params[:search]}%")
            Rails.logger.debug "Filtered Buildings: #{buildings.to_sql}" # Log the filtered query
        end
        buildings
    end

    def sort_buildings(buildings)
        case params[:sort]
        when 'name'
            buildings.order(:name)
        when 'height'
            buildings.order(:height)
        else
            buildings
        end
    end

    def generate_csv(buildings)
        CSV.generate(headers: true) do |csv|
            csv << ['Name', 'Height']
            buildings.each do |building|
                csv << [building.name, building.height]
            end
        end
    end
end
