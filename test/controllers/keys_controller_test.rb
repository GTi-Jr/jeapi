require 'test_helper'

class KeysControllerTest < ActionController::TestCase
  setup do
    @key = keys(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:keys)
  end

  test "should create key" do
    assert_difference('Key.count') do
      post :create, key: { password: @key.password }
    end

    assert_response 201
  end

  test "should show key" do
    get :show, id: @key
    assert_response :success
  end

  test "should update key" do
    put :update, id: @key, key: { password: @key.password }
    assert_response 204
  end

  test "should destroy key" do
    assert_difference('Key.count', -1) do
      delete :destroy, id: @key
    end

    assert_response 204
  end
end
