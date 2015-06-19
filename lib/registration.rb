class Registration
  ATTRIBUTES = {
    :id => "INTEGER PRIMARY KEY AUTOINCREMENT",
    :course_id => "INTEGER",
    :student_id => "INTEGER"
  }

  def self.attributes
    ATTRIBUTES
  end

  extend Persistable::ClassMethods
  include Persistable::InstanceMethods

  attr_accessor :id, *self.public_attributes
end
