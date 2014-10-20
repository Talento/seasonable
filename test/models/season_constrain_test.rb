require "test_helper"

describe SeasonConstrain do
  let(:season_constrain){SeasonConstrain.new(starts_at: 2.days.ago)}

  it "should respond to target" do
    season_constrain.must_respond_to :target
  end

  it "should respond to ends_at" do
    season_constrain.must_respond_to :ends_at
  end

  it "should respond to starts_at" do
    season_constrain.must_respond_to :starts_at
  end

  describe "#starts_at" do
    let(:invalid_season_constrain) { SeasonConstrain.new }
    it "must be invalid without a starts_at" do
      invalid_season_constrain.wont_be :valid?
    end
  end

  describe "::expiring_soon" do
    let(:constrain_1){ FactoryGirl.create(:season_constrain) }
    let(:constrain_2){ FactoryGirl.create(:season_constrain, :expires_past_tomorrow) }
    let(:constrain_3){ FactoryGirl.create(:season_constrain, :expired) }
    let(:constrain_4){ FactoryGirl.create(:season_constrain, :expires_in_23_hours) }
    let(:constrain_5){ FactoryGirl.create(:season_constrain, :expires_in_23_hours) }

    before(:each) do
      constrain_1
      constrain_2
      constrain_3
      constrain_4
      constrain_5
    end

    it "must return the right constrains only" do
      SeasonConstrain.expiring_soon.must_equal [constrain_4, constrain_5]
    end
  end

  describe "::expiring_soon_content" do

    let(:seasonable_dummy){ SeasonableDummy.new }

    let(:constrain_1){ FactoryGirl.create(:season_constrain) }
    let(:constrain_2){ FactoryGirl.create(:season_constrain, :expires_past_tomorrow) }
    let(:constrain_3){ FactoryGirl.create(:season_constrain, :expired) }
    let(:constrain_4){ FactoryGirl.create(:season_constrain, :expires_in_23_hours) }
    let(:constrain_5){ FactoryGirl.create(:season_constrain, :expires_in_23_hours, target: seasonable_dummy) }

    before(:each) do
      constrain_1
      constrain_2
      constrain_3
      constrain_4
      constrain_5
    end

    it "must return the right content" do
      SeasonConstrain.expiring_soon_content.must_equal [seasonable_dummy]
    end

  end

end
