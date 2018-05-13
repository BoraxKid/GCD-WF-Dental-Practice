require_relative '../../test_helper'

class Admin::DentistsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @dentist = dentists(:default)
  end

  # Vanilla CMS has BasicAuth, so we need to send that with each request.
  # Change this to fit your app's authentication strategy.
  # Move this to test_helper.rb
  def r(verb, path, options = {})
    headers = options[:headers] || {}
    headers['HTTP_AUTHORIZATION'] =
      ActionController::HttpAuthentication::Basic.encode_credentials(
        ComfortableMexicanSofa::AccessControl::AdminAuthentication.username,
        ComfortableMexicanSofa::AccessControl::AdminAuthentication.password
      )
    options.merge!(headers: headers)
    send(verb, path, options)
  end

  def test_get_index
    r :get, admin_dentists_path
    assert_response :success
    assert assigns(:dentists)
    assert_template :index
  end

  def test_get_show
    r :get, admin_dentist_path(@dentist)
    assert_response :success
    assert assigns(:dentist)
    assert_template :show
  end

  def test_get_show_failure
    r :get, admin_dentist_path('invalid')
    assert_response :redirect
    assert_redirected_to action: :index
    assert_equal 'Dentist not found', flash[:danger]
  end

  def test_get_new
    r :get, new_admin_dentist_path
    assert_response :success
    assert assigns(:dentist)
    assert_template :new
    assert_select "form[action='/admin/dentists']"
  end

  def test_get_edit
    r :get, edit_admin_dentist_path(@dentist)
    assert_response :success
    assert assigns(:dentist)
    assert_template :edit
    assert_select "form[action='/admin/dentists/#{@dentist.id}']"
  end

  def test_creation
    assert_difference 'Dentist.count' do
      r :post, admin_dentists_path, params: {dentist: {
        name: 'test name',
        email: 'test email',
        phone_number: 'test phone_number',
        dental_number: 'test dental_number',
        is_active: 'test is_active',
      }}
      dentist = Dentist.last
      assert_response :redirect
      assert_redirected_to action: :show, id: dentist
      assert_equal 'Dentist created', flash[:success]
    end
  end

  def test_creation_failure
    assert_no_difference 'Dentist.count' do
      r :post, admin_dentists_path, params: {dentist: { }}
      assert_response :success
      assert_template :new
      assert_equal 'Failed to create Dentist', flash[:danger]
    end
  end

  def test_update
    r :put, admin_dentist_path(@dentist), params: {dentist: {
      name: 'Updated'
    }}
    assert_response :redirect
    assert_redirected_to action: :show, id: @dentist
    assert_equal 'Dentist updated', flash[:success]
    @dentist.reload
    assert_equal 'Updated', @dentist.name
  end

  def test_update_failure
    r :put, admin_dentist_path(@dentist), params: {dentist: {
      name: ''
    }}
    assert_response :success
    assert_template :edit
    assert_equal 'Failed to update Dentist', flash[:danger]
    @dentist.reload
    refute_equal '', @dentist.name
  end

  def test_destroy
    assert_difference 'Dentist.count', -1 do
      r :delete, admin_dentist_path(@dentist)
      assert_response :redirect
      assert_redirected_to action: :index
      assert_equal 'Dentist deleted', flash[:success]
    end
  end
end
