require_relative '../../test_helper'

class Admin::ContactsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @contact = contacts(:default)
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
    r :get, admin_contacts_path
    assert_response :success
    assert assigns(:contacts)
    assert_template :index
  end

  def test_get_show
    r :get, admin_contact_path(@contact)
    assert_response :success
    assert assigns(:contact)
    assert_template :show
  end

  def test_get_show_failure
    r :get, admin_contact_path('invalid')
    assert_response :redirect
    assert_redirected_to action: :index
    assert_equal 'Contact not found', flash[:danger]
  end

  def test_get_new
    r :get, new_admin_contact_path
    assert_response :success
    assert assigns(:contact)
    assert_template :new
    assert_select "form[action='/admin/contacts']"
  end

  def test_get_edit
    r :get, edit_admin_contact_path(@contact)
    assert_response :success
    assert assigns(:contact)
    assert_template :edit
    assert_select "form[action='/admin/contacts/#{@contact.id}']"
  end

  def test_creation
    assert_difference 'Contact.count' do
      r :post, admin_contacts_path, params: {contact: {
        name: 'test name',
        email: 'test email',
        message: 'test message',
      }}
      contact = Contact.last
      assert_response :redirect
      assert_redirected_to action: :show, id: contact
      assert_equal 'Contact created', flash[:success]
    end
  end

  def test_creation_failure
    assert_no_difference 'Contact.count' do
      r :post, admin_contacts_path, params: {contact: { }}
      assert_response :success
      assert_template :new
      assert_equal 'Failed to create Contact', flash[:danger]
    end
  end

  def test_update
    r :put, admin_contact_path(@contact), params: {contact: {
      name: 'Updated'
    }}
    assert_response :redirect
    assert_redirected_to action: :show, id: @contact
    assert_equal 'Contact updated', flash[:success]
    @contact.reload
    assert_equal 'Updated', @contact.name
  end

  def test_update_failure
    r :put, admin_contact_path(@contact), params: {contact: {
      name: ''
    }}
    assert_response :success
    assert_template :edit
    assert_equal 'Failed to update Contact', flash[:danger]
    @contact.reload
    refute_equal '', @contact.name
  end

  def test_destroy
    assert_difference 'Contact.count', -1 do
      r :delete, admin_contact_path(@contact)
      assert_response :redirect
      assert_redirected_to action: :index
      assert_equal 'Contact deleted', flash[:success]
    end
  end
end
