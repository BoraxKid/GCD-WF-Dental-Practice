require_relative '../../test_helper'

class Admin::AppointmentsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @appointment = appointments(:default)
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
    r :get, admin_appointments_path
    assert_response :success
    assert assigns(:appointments)
    assert_template :index
  end

  def test_get_show
    r :get, admin_appointment_path(@appointment)
    assert_response :success
    assert assigns(:appointment)
    assert_template :show
  end

  def test_get_show_failure
    r :get, admin_appointment_path('invalid')
    assert_response :redirect
    assert_redirected_to action: :index
    assert_equal 'Appointment not found', flash[:danger]
  end

  def test_get_new
    r :get, new_admin_appointment_path
    assert_response :success
    assert assigns(:appointment)
    assert_template :new
    assert_select "form[action='/admin/appointments']"
  end

  def test_get_edit
    r :get, edit_admin_appointment_path(@appointment)
    assert_response :success
    assert assigns(:appointment)
    assert_template :edit
    assert_select "form[action='/admin/appointments/#{@appointment.id}']"
  end

  def test_creation
    assert_difference 'Appointment.count' do
      r :post, admin_appointments_path, params: {appointment: {
        date: 'test date',
        dentist: 'test dentist',
        patient: 'test patient',
        duration: 'test duration',
        fee_paid: 'test fee_paid',
        notes: 'test notes',
      }}
      appointment = Appointment.last
      assert_response :redirect
      assert_redirected_to action: :show, id: appointment
      assert_equal 'Appointment created', flash[:success]
    end
  end

  def test_creation_failure
    assert_no_difference 'Appointment.count' do
      r :post, admin_appointments_path, params: {appointment: { }}
      assert_response :success
      assert_template :new
      assert_equal 'Failed to create Appointment', flash[:danger]
    end
  end

  def test_update
    r :put, admin_appointment_path(@appointment), params: {appointment: {
      date: 'Updated'
    }}
    assert_response :redirect
    assert_redirected_to action: :show, id: @appointment
    assert_equal 'Appointment updated', flash[:success]
    @appointment.reload
    assert_equal 'Updated', @appointment.date
  end

  def test_update_failure
    r :put, admin_appointment_path(@appointment), params: {appointment: {
      date: ''
    }}
    assert_response :success
    assert_template :edit
    assert_equal 'Failed to update Appointment', flash[:danger]
    @appointment.reload
    refute_equal '', @appointment.date
  end

  def test_destroy
    assert_difference 'Appointment.count', -1 do
      r :delete, admin_appointment_path(@appointment)
      assert_response :redirect
      assert_redirected_to action: :index
      assert_equal 'Appointment deleted', flash[:success]
    end
  end
end
