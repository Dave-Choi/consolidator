require 'test_helper'

class BorrowRequestsControllerTest < ActionController::TestCase
  setup do
    @borrow_request = borrow_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:borrow_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create borrow_request" do
    assert_difference('BorrowRequest.count') do
      post :create, borrow_request: {  }
    end

    assert_redirected_to borrow_request_path(assigns(:borrow_request))
  end

  test "should show borrow_request" do
    get :show, id: @borrow_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @borrow_request
    assert_response :success
  end

  test "should update borrow_request" do
    put :update, id: @borrow_request, borrow_request: {  }
    assert_redirected_to borrow_request_path(assigns(:borrow_request))
  end

  test "should destroy borrow_request" do
    assert_difference('BorrowRequest.count', -1) do
      delete :destroy, id: @borrow_request
    end

    assert_redirected_to borrow_requests_path
  end
end
