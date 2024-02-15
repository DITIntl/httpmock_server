# frozen_string_literal: true

require 'test_helper'

class ServerControllerTest < ActionDispatch::IntegrationTest
  content_type_json = 'application/json'

  test 'should GET /server' do
    get '/server',
        headers: { 'Accept' => content_type_json, 'response-headers' => '[{"Content-Type": "application/json"}]' }
    assert_response :success
    assert_equal content_type_json, @response.media_type
  end

  test 'should POST /server' do
    post '/server',
         headers: { 'Accept' => content_type_json, 'response-status' => 500,
                    'response-headers' => '[{"Content-Type": "application/json"}]' }
    assert_response :internal_server_error
    assert_equal content_type_json, @response.media_type
  end

  test 'should PATCH /server' do
    patch '/server',
          headers: { 'Accept' => content_type_json, 'response-headers' => '[{"Content-Type": "application/json"}]' }
    assert_response :success
    assert_equal content_type_json, @response.media_type
  end

  test 'should PUT /server' do
    put '/server',
        headers: { 'Accept' => content_type_json, 'response-headers' => '[{"Content-Type": "application/json"}]' }
    assert_response :success
    assert_equal content_type_json, @response.media_type
  end

  test 'should DELETE /server' do
    start = DateTime.now
    delete '/server',
           headers: { 'Accept' => content_type_json, 'response-delay' => '350',
                      'response-headers' => '[{"Content-Type": "application/json"}]' }
    assert_response :success
    assert_equal content_type_json, @response.media_type
    assert time_diff_milli(start) >= 350
  end
end
