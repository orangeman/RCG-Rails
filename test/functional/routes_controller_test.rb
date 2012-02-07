require 'test_helper'

class RoutesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:routes)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_route
    assert_difference('Route.count') do
      post :create, :route => { }
    end

    assert_redirected_to route_path(assigns(:route))
  end

  def test_should_show_route
    get :show, :id => routes(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => routes(:one).id
    assert_response :success
  end

  def test_should_update_route
    put :update, :id => routes(:one).id, :route => { }
    assert_redirected_to route_path(assigns(:route))
  end

  def test_should_destroy_route
    assert_difference('Route.count', -1) do
      delete :destroy, :id => routes(:one).id
    end

    assert_redirected_to routes_path
  end
end
