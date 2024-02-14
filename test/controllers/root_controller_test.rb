# frozen_string_literal: true

require 'test_helper'

class RootControllerTest < ActionDispatch::IntegrationTest
  content_type_json = 'application/json'
  content_type_html = 'text/html'

  test "should GET / #{content_type_json}" do
    get '/', headers: { 'Accept' => content_type_json, 'response-headers' => '[{"Content-Type": "application/json"}]' }
    assert_response :success
    assert_equal content_type_json, @response.media_type
  end

  test "should GET / #{content_type_html}" do
    get '/', headers: { 'Accept' => content_type_html }
    assert_response :success
    assert_equal content_type_html, @response.media_type
  end

  test "should POST / #{content_type_json}" do
    post '/',
         headers: { 'Accept' => content_type_json, 'response-status' => 500,
                    'response-headers' => '[{"Content-Type": "application/json"}]' }
    assert_response :internal_server_error
    assert_equal content_type_json, @response.media_type
  end

  test "should PATCH / #{content_type_json}" do
    patch '/',
          headers: { 'Accept' => content_type_json, 'response-headers' => '[{"Content-Type": "application/json"}]' }
    assert_response :success
    assert_equal content_type_json, @response.media_type
  end

  test "should PUT / #{content_type_json}" do
    put '/', headers: { 'Accept' => content_type_json, 'response-headers' => '[{"Content-Type": "application/json"}]' }
    assert_response :success
    assert_equal content_type_json, @response.media_type
  end

  test "should DELETE / #{content_type_json}" do
    delete '/',
           headers: { 'Accept' => content_type_json, 'response-headers' => '[{"Content-Type": "application/json"}]' }
    assert_response :success
    assert_equal content_type_json, @response.media_type
  end
end
