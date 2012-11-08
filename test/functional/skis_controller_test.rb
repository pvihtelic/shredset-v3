require 'test_helper'

class SkisControllerTest < ActionController::TestCase
  setup do
    @ski = skis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:skis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ski" do
    assert_difference('Ski.count') do
      post :create, ski: { ability_level: @ski.ability_level, brand_id: @ski.brand_id, description: @ski.description, gender: @ski.gender, model_year: @ski.model_year, name: @ski.name, rocker_type: @ski.rocker_type, ski_type: @ski.ski_type }
    end

    assert_redirected_to ski_path(assigns(:ski))
  end

  test "should show ski" do
    get :show, id: @ski
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ski
    assert_response :success
  end

  test "should update ski" do
    put :update, id: @ski, ski: { ability_level: @ski.ability_level, brand_id: @ski.brand_id, description: @ski.description, gender: @ski.gender, model_year: @ski.model_year, name: @ski.name, rocker_type: @ski.rocker_type, ski_type: @ski.ski_type }
    assert_redirected_to ski_path(assigns(:ski))
  end

  test "should destroy ski" do
    assert_difference('Ski.count', -1) do
      delete :destroy, id: @ski
    end

    assert_redirected_to skis_path
  end
end
