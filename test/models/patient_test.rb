require_relative '../test_helper'

class PatientTest < ActiveSupport::TestCase

  def test_fixtures_validity
    Patient.all.each do |patient|
      assert patient.valid?, patient.errors.inspect
    end
  end

  def test_validation
    patient = Patient.new
    assert patient.invalid?
    assert_equal [:name, :emai, :phone_number, :allergies, :medical_notes], patient.errors.keys
  end

  def test_creation
    assert_difference 'Patient.count' do
      Patient.create(
        name: 'test name',
        emai: 'test emai',
        phone_number: 'test phone_number',
        allergies: 'test allergies',
        medical_notes: 'test medical_notes',
      )
    end
  end
end
