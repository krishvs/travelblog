require 'test_helper'

class ItenariesControllerTest < ActionController::TestCase
  setup do
    @itenary = itenaries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:itenaries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create itenary" do
    assert_difference('Itenary.count') do
      post :create, itenary: { folder_id: @itenary.folder_id, name: @itenary.name, user_id: @itenary.user_id }
    end

    assert_redirected_to itenary_path(assigns(:itenary))
  end

  test "should show itenary" do
    get :show, id: @itenary
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @itenary
    assert_response :success
  end

  test "should update itenary" do
    patch :update, id: @itenary, itenary: { folder_id: @itenary.folder_id, name: @itenary.name, user_id: @itenary.user_id }
    assert_redirected_to itenary_path(assigns(:itenary))
  end

  test "should destroy itenary" do
    assert_difference('Itenary.count', -1) do
      delete :destroy, id: @itenary
    end

    assert_redirected_to itenaries_path
  end
end
