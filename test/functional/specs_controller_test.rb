require 'test_helper'

class SpecsControllerTest < ActionController::TestCase
  setup do
    @spec = specs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:specs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create spec" do
    assert_difference('Spec.count') do
      post :create, spec: { length: @spec.length, ski_id: @spec.ski_id, tail_width: @spec.tail_width, tip_width: @spec.tip_width, turning_radius: @spec.turning_radius, waist_width: @spec.waist_width, weight: @spec.weight }
    end

    assert_redirected_to spec_path(assigns(:spec))
  end

  test "should show spec" do
    get :show, id: @spec
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @spec
    assert_response :success
  end

  test "should update spec" do
    put :update, id: @spec, spec: { length: @spec.length, ski_id: @spec.ski_id, tail_width: @spec.tail_width, tip_width: @spec.tip_width, turning_radius: @spec.turning_radius, waist_width: @spec.waist_width, weight: @spec.weight }
    assert_redirected_to spec_path(assigns(:spec))
  end

  test "should destroy spec" do
    assert_difference('Spec.count', -1) do
      delete :destroy, id: @spec
    end

    assert_redirected_to specs_path
  end
end
