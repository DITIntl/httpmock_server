# frozen_string_literal: true

require 'test_helper'

class StatusControllerTest < ActionDispatch::IntegrationTest
  content_type_json = 'application/json'

  test 'should DELETE /status/100' do
    delete '/status/100'
    assert_response :continue
    assert_equal nil, @response.media_type
  end

  test 'should GET /status/200' do
    get '/status/200'
    assert_response :success
    assert_equal content_type_json, @response.media_type
  end

  test 'should POST /status/500?delay=900' do
    start = DateTime.now
    post '/status/500?delay=900'
    assert_response :internal_server_error
    assert_equal content_type_json, @response.media_type
    assert time_diff_milli(start) >= 900
  end

  test 'should PATCH /status/404' do
    patch '/status/404'
    assert_response :not_found
    assert_equal content_type_json, @response.media_type
  end

  test 'should PUT /status/305?delay=100' do
    start = DateTime.now
    put '/status/305?delay=100'
    assert_response :use_proxy
    assert_equal content_type_json, @response.media_type
    assert time_diff_milli(start) >= 100
  end
end
