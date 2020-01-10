require 'rails_helper'

RSpec.describe "Enemies", type: :request do
  describe 'GET /enemies' do
    context 'when there are enemies' do
      let(:enemies_attributes) { attributes_for_list(:enemy, 5) }

      before(:each) {
        enemies_attributes.each do |enemy_attribute|
          post enemies_path, params: enemy_attribute
        end
      }

      it 'returns a list of enemies' do
        get enemies_path
        response_hash = JSON.parse(response.body, symbolize_names: true)

        response_hash.each_with_index do |element, index|
          expect(element).to include(enemies_attributes[index])
        end 
      end

      it 'returns a specific enemy by id' do
        get '/enemies/1'
        response_hash = JSON.parse(response.body, symbolize_names: true)
        expect(response_hash).to include(enemies_attributes[0])
      end
    end

    context 'when there are no enemies' do
      it 'returns status code 404' do
        get enemies_path
        expect(response.body).to eq('[]')
      end
      it 'returns a not found message' do
        get '/enemies/1'
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end

  describe 'POST /enemies' do
    context 'creating enemies' do
      let(:enemies_attributes) { attributes_for_list(:enemy, 5) }

      it 'creates 5 enemies' do
        enemies_attributes.each do |enemy_attribute|
          post enemies_path, params: enemy_attribute
        end

        get '/enemies/1'
        response_hash = JSON.parse(response.body, symbolize_names: true)
        expect(response_hash).to include(enemies_attributes[0])
      end
    end
  end
  
  describe 'PUT /enemies' do
    context 'when the enemy exists' do
      let(:enemy) { create(:enemy) }
      let(:enemy_attributes) { attributes_for(:enemy) }

      before(:each) { put "/enemies/#{enemy.id}", params: enemy_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the enemy' do
        expect(enemy.reload).to have_attributes(enemy_attributes)
      end

      it 'returns the enemy updated' do
        expect(enemy.reload).to have_attributes(json.except('created_at', 'updated_at'))
      end
    end

    context 'when the enemy does not exist' do
      it 'returns status code 404' do
        put '/enemies/0', params: attributes_for(:enemy)
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        put '/enemies/0', params: attributes_for(:enemy)
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end

  describe 'DELETE /enemies' do
    let(:enemy) { create(:enemy) }
    before(:each) { delete "/enemies/#{enemy.id}" }

    context 'when the enemy exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'destroy the record' do
        expect { enemy.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'when the enemy does not exist' do
      before(:each) { delete '/enemies/0' }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end
end
