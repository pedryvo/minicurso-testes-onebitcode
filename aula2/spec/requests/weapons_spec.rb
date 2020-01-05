require 'rails_helper'

RSpec.describe "Weapons", type: :request do
  describe "GET /weapons" do
    it "returns success status" do
      get weapons_path
      expect(response).to have_http_status(200)
    end

    it 'verifies if names are exibited' do
      weapons = create_list(:weapon, 5)
      get weapons_path
      weapons.each do |weapon|
        expect(response.body).to include(weapon.name)
      end
    end

    it 'verifies if current_powers are exibited' do
      weapons = create_list(:weapon, 5)
      get weapons_path
      weapons.each do |weapon|
        expect(response.body).to include(weapon.current_power.to_s)
      end
    end

    it 'verifies if titles are exibited' do
      weapons = create_list(:weapon, 5)
      get weapons_path
      weapons.each do |weapon|
        expect(response.body).to include(weapon.title)
      end
    end

    it 'verifies if links are correctly exibited' do
      weapons = create_list(:weapon, 5)
      get weapons_path
      weapons.each do |weapon|
        expect(response.body).to include('<a href="'+"/weapons/#{weapon.id}"+'"'+">#{weapon.name}</a>")
      end
    end
  end

  describe 'POST /weapons' do
    context 'when it has valid parameters' do
      it 'creates a weapon with correct attributes' do
        weapon_attributes = FactoryBot.attributes_for(:weapon)
        post weapons_path, params: { weapon: weapon_attributes }
        expect(Weapon.last).to have_attributes(weapon_attributes)
      end
    end

    context 'when it has no valid parameters' do
      it 'does not create a weapon' do
        expect{
          post weapons_path, params: { weapon: { name: '', description: '', level: '' } }
        }.to_not change(Weapon, :count)
      end
    end
  end
end
