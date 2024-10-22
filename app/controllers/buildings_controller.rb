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
        @buildings = case params[:sort]
        when 'name'
            Building.order(:name)
        when 'height'
            Building.order(:height)
        else
            Building.all
        end
    end

    def edit
        @building = Building.find(params[:id])
    end

    def show
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

    private

    def building_params
        params.require(:building).permit(:name, :height)
    end
end
