require_relative '../../test_helper'

class Admin::PatientsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @patient = patients(:default)
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
    r :get, admin_patients_path
    assert_response :success
    assert assigns(:patients)
    assert_template :index
  end

  def test_get_show
    r :get, admin_patient_path(@patient)
    assert_response :success
    assert assigns(:patient)
    assert_template :show
  end

  def test_get_show_failure
    r :get, admin_patient_path('invalid')
    assert_response :redirect
    assert_redirected_to action: :index
    assert_equal 'Patient not found', flash[:danger]
  end

  def test_get_new
    r :get, new_admin_patient_path
    assert_response :success
    assert assigns(:patient)
    assert_template :new
    assert_select "form[action='/admin/patients']"
  end

  def test_get_edit
    r :get, edit_admin_patient_path(@patient)
    assert_response :success
    assert assigns(:patient)
    assert_template :edit
    assert_select "form[action='/admin/patients/#{@patient.id}']"
  end

  def test_creation
    assert_difference 'Patient.count' do
      r :post, admin_patients_path, params: {patient: {
        name: 'test name',
        emai: 'test emai',
        phone_number: 'test phone_number',
        allergies: 'test allergies',
        medical_notes: 'test medical_notes',
      }}
      patient = Patient.last
      assert_response :redirect
      assert_redirected_to action: :show, id: patient
      assert_equal 'Patient created', flash[:success]
    end
  end

  def test_creation_failure
    assert_no_difference 'Patient.count' do
      r :post, admin_patients_path, params: {patient: { }}
      assert_response :success
      assert_template :new
      assert_equal 'Failed to create Patient', flash[:danger]
    end
  end

  def test_update
    r :put, admin_patient_path(@patient), params: {patient: {
      name: 'Updated'
    }}
    assert_response :redirect
    assert_redirected_to action: :show, id: @patient
    assert_equal 'Patient updated', flash[:success]
    @patient.reload
    assert_equal 'Updated', @patient.name
  end

  def test_update_failure
    r :put, admin_patient_path(@patient), params: {patient: {
      name: ''
    }}
    assert_response :success
    assert_template :edit
    assert_equal 'Failed to update Patient', flash[:danger]
    @patient.reload
    refute_equal '', @patient.name
  end

  def test_destroy
    assert_difference 'Patient.count', -1 do
      r :delete, admin_patient_path(@patient)
      assert_response :redirect
      assert_redirected_to action: :index
      assert_equal 'Patient deleted', flash[:success]
    end
  end
end
