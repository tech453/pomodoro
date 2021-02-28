require 'test_helper'

class MemosControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get memos_edit_url
    assert_response :success
  end

end
