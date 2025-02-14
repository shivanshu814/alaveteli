# == Schema Information
# Schema version: 20210114161442
#
# Table name: request_classifications
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  info_request_event_id :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'spec_helper'

RSpec.describe RequestClassification do

  describe '.league_table' do

    before do
      @user_one = FactoryBot.create(:user)
      @user_two = FactoryBot.create(:user)
      FactoryBot.create(:request_classification, user: @user_one)
      FactoryBot.create(:request_classification, user: @user_one)
      FactoryBot.create(:request_classification, user: @user_two)
    end

    it "returns a list of users' classifications with counts in descending order" do
      league_table = RequestClassification.league_table(5, nil)
      expect(league_table.length).to eq(2)
      expect(league_table.first.user_id).to eq(@user_one.id)
      expect(league_table.first.cnt).to eq(2)
      expect(league_table.second.user_id).to eq(@user_two.id)
      expect(league_table.second.cnt).to eq(1)
    end

    it 'applies a limit param' do
      league_table = RequestClassification.league_table(1, nil)
      expect(league_table.length).to eq(1)
    end

    it 'applies a conditions param' do
      league_table = RequestClassification.league_table(1, ["user_id = ?", @user_two])
      expect(league_table.length).to eq(1)
      expect(league_table.first.user_id).to eq(@user_two.id)
      expect(league_table.first.cnt).to eq(1)
    end

  end

end
