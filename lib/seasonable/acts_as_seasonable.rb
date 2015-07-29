module Seasonable
  module ActsAsSeasonable
    extend ActiveSupport::Concern

    included do
      has_many :season_constrains, as: :target, class_name: 'Seasonable::SeasonConstrain'
      accepts_nested_attributes_for :season_constrains, allow_destroy: true
      scope :visible_today, -> {joins(:season_constrains).where("(:now BETWEEN season_constrains.starts_at AND season_constrains.ends_at) OR (season_constrains.ends_at IS NULL AND season_constrains.starts_at < :now)", now: Time.now)}
    end

    def visible_today?
      right_now = Time.now
      season_constrains.any? do |season|
        season.starts_at < right_now && (season.ends_at.nil? || season.ends_at > right_now)
      end || false
    end
  end

  module SeasonsHelper
    def seasons_for seasonable, options = {}
      @template.render :partial=>"/seasonable/seasons_for", locals: {seasonable: seasonable, form: self}
    end
  end
end

ActionView::Helpers::FormBuilder.send(:include, Seasonable::SeasonsHelper)
