require "test_helper"

class MessageControllerTest < ActionDispatch::IntegrationTest
  test "should get date:datetime" do
    get message_date:datetime_url
    assert_response :success
  end

  test "should get text:string" do
    get message_text:string_url
    assert_response :success
  end

  test "should get user:references" do
    get message_user:references_url
    assert_response :success
  end

  test "should get desk:references" do
    get message_desk:references_url
    assert_response :success
  end
end
