require 'test_helper'

class JuniorEnterprisesControllerTest < ActionController::TestCase
  setup do
    @junior_enterprise = junior_enterprises(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:junior_enterprises)
  end

  test "should create junior_enterprise" do
    assert_difference('JuniorEnterprise.count') do
      post :create, junior_enterprise: { accesss: @junior_enterprise.accesss, address: @junior_enterprise.address, area: @junior_enterprise.area, city: @junior_enterprise.city, consultor: @junior_enterprise.consultor, course: @junior_enterprise.course, description: @junior_enterprise.description, facebook: @junior_enterprise.facebook, logo: @junior_enterprise.logo, name: @junior_enterprise.name, phone: @junior_enterprise.phone, phrase: @junior_enterprise.phrase, product: @junior_enterprise.product, project: @junior_enterprise.project, site: @junior_enterprise.site, state: @junior_enterprise.state, training: @junior_enterprise.training, youtube: @junior_enterprise.youtube }
    end

    assert_response 201
  end

  test "should show junior_enterprise" do
    get :show, id: @junior_enterprise
    assert_response :success
  end

  test "should update junior_enterprise" do
    put :update, id: @junior_enterprise, junior_enterprise: { accesss: @junior_enterprise.accesss, address: @junior_enterprise.address, area: @junior_enterprise.area, city: @junior_enterprise.city, consultor: @junior_enterprise.consultor, course: @junior_enterprise.course, description: @junior_enterprise.description, facebook: @junior_enterprise.facebook, logo: @junior_enterprise.logo, name: @junior_enterprise.name, phone: @junior_enterprise.phone, phrase: @junior_enterprise.phrase, product: @junior_enterprise.product, project: @junior_enterprise.project, site: @junior_enterprise.site, state: @junior_enterprise.state, training: @junior_enterprise.training, youtube: @junior_enterprise.youtube }
    assert_response 204
  end

  test "should destroy junior_enterprise" do
    assert_difference('JuniorEnterprise.count', -1) do
      delete :destroy, id: @junior_enterprise
    end

    assert_response 204
  end
end
