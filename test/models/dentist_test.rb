require_relative '../test_helper'

class DentistTest < ActiveSupport::TestCase

  def test_fixtures_validity
    Dentist.all.each do |dentist|
      assert dentist.valid?, dentist.errors.inspect
    end
  end

  def test_validation
    dentist = Dentist.new
    assert dentist.invalid?
    assert_equal [:name, :email, :phone_number, :dental_number, :is_active], dentist.errors.keys
  end

  def test_creation
    assert_difference 'Dentist.count' do
      Dentist.create(
        name: 'test name',
        email: 'test email',
        phone_number: 'test phone_number',
        dental_number: 'test dental_number',
        is_active: 'test is_active',
      )
    end
  end
end
