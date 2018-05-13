class Patient < ActiveRecord::Base

  # -- Relationships -----------------------------------------------------------
  has_many :appointments
  has_many :dentist, through: :appointments

  # -- Callbacks ---------------------------------------------------------------


  # -- Validations -------------------------------------------------------------
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_PHONE_NUMBER_REGEX = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/i

  validates :name,          presence: true,  length: { maximum: 30 }
  validates :email,         presence: true,  length: { maximum: 30 }, format: { with: VALID_EMAIL_REGEX }
  validates :phone_number,  presence: true,  length: { maximum: 30 }, format: { with: VALID_PHONE_NUMBER_REGEX }
  validates :allergies,     presence: false, length: { maximum: 1000 }
  validates :medical_notes, presence: false, length: { maximum: 1000 }

  # -- Scopes ------------------------------------------------------------------


  # -- Class Methods -----------------------------------------------------------


  # -- Instance Methods --------------------------------------------------------


end
