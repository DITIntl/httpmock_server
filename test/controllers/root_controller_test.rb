# frozen_string_literal: true

require 'test_helper'

class RootControllerTest < ActionDispatch::IntegrationTest
  test 'should GET /' do
    get '/'
    assert_response :success
  end
end
