require 'test_helper'

describe Seasonable do
  describe "#models " do
    models = [SeasonableDummy]

    models.each do |model|
      describe "#{model} " do
        it "must respond to season_constrains" do
          model.new.must_respond_to :season_constrains
        end

        it "must respond to visible_today?" do
          model.new.must_respond_to :visible_today?
        end

        it "must respond to visible_today scope" do
          model.must_respond_to :visible_today
        end

        describe "with empty season constrains" do
          let(:seasonable_model){model.new}

          it "season_constrains must be empty" do
            seasonable_model.season_constrains.must_be_empty
          end
        end

        describe "with season constrains that never ends visible today" do
          before(:each) do
            @attributes = {season_constrains_attributes: {"1" => {starts_at: 2.days.ago}}}
          end

          it "should have created a season constrain" do
            model.create(@attributes)
            SeasonConstrain.all.count.must_equal 1
          end

          it "should be visible today" do
            seasonable_model = model.create(@attributes)
            seasonable_model.must_be :visible_today?
          end
        end

        describe "with season constrain that never ends not visible today" do
          before(:each) do
            @attributes = {season_constrains_attributes: {"1" => {starts_at: 2.days.from_now}}}
          end

          it "should not be visible today" do
            seasonable_model = model.create(@attributes)
            seasonable_model.wont_be :visible_today?
          end
        end

        describe "with season constrains with finalization date that is not visible today" do
          before(:each) do
            @attributes = {season_constrains_attributes: {"1" => {starts_at: 5.days.ago, ends_at: 1.day.ago}}}
          end

          it "should not be visible today" do
            seasonable_model = model.create(@attributes)
            seasonable_model.wont_be :visible_today?
          end
        end

        describe "with season constrains with finalization date that is visible today" do
          before(:each) do
            @attributes = {season_constrains_attributes: {"1" => {starts_at: 5.days.ago, ends_at: 1.day.from_now}}}
          end

          it "should not be visible today" do
            seasonable_model = model.create(@attributes)
            seasonable_model.must_be :visible_today?
          end
        end
      end
    end
  end
end