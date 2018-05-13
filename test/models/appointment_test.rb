require_relative '../test_helper'

class AppointmentTest < ActiveSupport::TestCase

  def test_fixtures_validity
    Appointment.all.each do |appointment|
      assert appointment.valid?, appointment.errors.inspect
    end
  end

  def test_validation
    appointment = Appointment.new
    assert appointment.invalid?
    assert_equal [:date, :dentist, :patient, :duration, :fee_paid, :notes], appointment.errors.keys
  end

  def test_creation
    assert_difference 'Appointment.count' do
      Appointment.create(
        date: 'test date',
        dentist: 'test dentist',
        patient: 'test patient',
        duration: 'test duration',
        fee_paid: 'test fee_paid',
        notes: 'test notes',
      )
    end
  end
end
