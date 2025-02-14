require 'spec_helper'

RSpec.describe 'request_game/play' do

    before do
        @mock_body = mock_model(PublicBody, name: 'test body',
                                            url_name: 'test_body')
        @mock_user = mock_model(User, name: 'test user',
                                      url_name: 'test_user',
                                      profile_photo: nil)
        @mock_request = mock_model(InfoRequest, title: 'test request',
                                                awaiting_description: false,
                                                law_used_with_a: 'A Freedom of Information request',
                                                law_used_full: 'Freedom of Information',
                                                public_body: @mock_body,
                                                url_title: 'a_test_request',
                                                user: @mock_user,
                                                calculate_status: 'waiting_response',
                                                date_response_required_by: Date.current,
                                                prominence: 'normal',
                                                initial_request_text: 'hi there',
                                                display_status: 'Awaiting categorisation',
                                                created_at: Time.zone.now)
        assign :league_table_28_days, []
        assign :league_table_all_time, []
        assign :requests, [@mock_request]
        assign :play_urls, true
    end

    it 'should show the correct url for a request' do
        render
        expect(response).to include("/categorise/request/a_test_request")
    end

end
