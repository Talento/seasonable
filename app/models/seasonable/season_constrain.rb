module Seasonable
  class SeasonConstrain < ActiveRecord::Base
    belongs_to :target, :polymorphic=>true
    validates :starts_at, presence: true
    scope :expiring_soon, -> {  where("? > ends_at AND ? < ends_at AND ends_at IS NOT NULL", Time.now + 24.hours, Time.now) }

    def self.expiring_soon_content
      expiring_soon.map(&:target).compact
    end
  end
end