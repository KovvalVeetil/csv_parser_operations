# spec/controllers/buildings_controller_spec.rb
require 'rails_helper'

RSpec.describe BuildingsController, type: :controller do
  describe 'BuildingsController' do
    before do
      @building = Building.create(name: 'Empire State Building', height: 381)
    end

    describe 'POST #upload_csv' do
      context 'with valid file' do
        it 'uploads the CSV and redirects to buildings path' do
          file = fixture_file_upload('test/fixtures/sample.csv', 'text/csv')
          post :upload_csv, params: { file: file }
          expect(response).to redirect_to(buildings_path)
          expect(flash[:notice]).to match('CSV uploaded and parsed successfully')
        end
      end

      context 'with no file' do
        it 'redirects to new_building_path with an alert' do
          post :upload_csv, params: {}
          expect(response).to redirect_to(new_building_path)
          expect(flash[:alert]).to match('No file uploaded.')
        end
      end
    end

    describe 'GET #index' do
      before do
        Building.create(name: 'Burj Khalifa', height: 828)
      end

      context 'without search or sort parameters' do
        it 'assigns all buildings to @buildings' do
          get :index
          expect(assigns(:buildings)).to match_array(Building.all)
        end
      end

      context 'with search parameter' do
        it 'filters buildings by name' do
          get :index, params: { search: 'Burj' }
          expect(assigns(:buildings)).to include(Building.find_by(name: 'Burj Khalifa'))
          expect(assigns(:buildings)).not_to include(Building.find_by(name: 'Empire State Building'))
        end
      end

      context 'with sort parameter' do
        it 'sorts buildings by name' do
            get :index, params: { sort: 'name', direction: 'asc' }
            expect(assigns(:buildings)).to match_array(Building.all.order(:name))
        end

        it 'sorts buildings by height' do
          get :index, params: { sort: 'height' }
          expect(assigns(:buildings)).to match_array(Building.order(:height))
        end
      end
    end

    describe 'GET #edit' do
      it 'assigns the requested building to @building' do
        get :edit, params: { id: @building.id }
        expect(assigns(:building)).to eq(@building)
      end
    end

    describe 'PATCH #update' do
      context 'with valid attributes' do
        it 'updates the building' do
          patch :update, params: { id: @building.id, building: { name: 'New Name', height: 400 } }
          @building.reload
          expect(@building.name).to eq('New Name')
          expect(@building.height).to eq(400)
        end
      end

      context 'with invalid attributes' do
        it 'renders the edit template' do
          patch :update, params: { id: @building.id, building: { name: '', height: -1 } }
          expect(response).to render_template(:edit)
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'deletes the building' do
        expect {
          delete :destroy, params: { id: @building.id }
        }.to change(Building, :count).by(-1)
      end

      it 'redirects to buildings path' do
        delete :destroy, params: { id: @building.id }
        expect(response).to redirect_to(buildings_path)
        expect(flash[:notice]).to match('Building was successfully deleted.')
      end
    end

    describe 'GET #export' do
      it 'responds with CSV format' do
        get :export, format: :csv
        expect(response.header['Content-Type']).to include 'text/csv'
      end

      it 'returns a 200 status code' do
        get :export, format: :csv
        expect(response).to have_http_status(:success)
      end
    end
   end
end
