class Appointment < ActiveRecord::Base

  # -- Relationships -----------------------------------------------------------
  belongs_to :dentist
  belongs_to :patient

  # -- Callbacks ---------------------------------------------------------------


  # -- Validations -------------------------------------------------------------


  # -- Scopes ------------------------------------------------------------------


  # -- Class Methods -----------------------------------------------------------


  # -- Instance Methods --------------------------------------------------------


end
