class Weapon < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :level, presence: true

  def current_power
    (power_base + ((level-1) * power_step))
  end

  def title
    "#{self.name} ##{self.level}"
  end
end
