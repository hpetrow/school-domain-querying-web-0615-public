class Department
  ATTRIBUTES = {
    :id => "INTEGER PRIMARY KEY AUTOINCREMENT",
    :name => "TEXT",
  }

  def self.attributes
    ATTRIBUTES
  end

  extend Persistable::ClassMethods
  include Persistable::InstanceMethods

  attr_accessor :id, *self.public_attributes

  def courses
    Course.find_all_by_department_id(self.id)
  end

  def add_course(course)
    course.department_id = self.id
    course.save
    self.save
  end
end
