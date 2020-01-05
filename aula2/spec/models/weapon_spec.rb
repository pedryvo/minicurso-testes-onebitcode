require 'rails_helper'

RSpec.describe Weapon, type: :model do
  it 'returns the correct weapon title' do
    weapon = build(:weapon)
    expect(weapon.title).to eq("#{weapon.name} ##{weapon.level}")
  end

  it "returns the correct weapon's current power" do
    weapon = build(:weapon, level: Faker::Number.between(from: 1, to: 99))
    expect(weapon.current_power).to eq(weapon.power_base + ((weapon.level-1) * weapon.power_step))
  end
end
