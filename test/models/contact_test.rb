require_relative '../test_helper'

class ContactTest < ActiveSupport::TestCase

  def test_fixtures_validity
    Contact.all.each do |contact|
      assert contact.valid?, contact.errors.inspect
    end
  end

  def test_validation
    contact = Contact.new
    assert contact.invalid?
    assert_equal [:name, :email, :message], contact.errors.keys
  end

  def test_creation
    assert_difference 'Contact.count' do
      Contact.create(
        name: 'test name',
        email: 'test email',
        message: 'test message',
      )
    end
  end
end
