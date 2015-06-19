require 'pry'

class Course
  ATTRIBUTES = {
    :id => "INTEGER PRIMARY KEY AUTOINCREMENT",
    :name => "TEXT",
    :department_id => "INTEGER"
  }

  def self.attributes
    ATTRIBUTES
  end

  extend Persistable::ClassMethods
  include Persistable::InstanceMethods

  attr_accessor :id, *self.public_attributes

  def self.find_all_by_department_id(department_id)
    sql = <<-SQL
      SELECT * FROM #{self.table_name} WHERE department_id = ? LIMIT 1;
    SQL
    rows = self.db.execute(sql, department_id)
    rows.collect { |row|
      self.new_from_db(row)
    }
  end

  def department=(department)
    @department = department
    @department_id = department.id
  end

  def department
    Department.find_by_id(department_id)
  end

  def students
    sql = <<-SQL
      SELECT * FROM students JOIN registrations ON students.id = registrations.student_id
      WHERE registrations.course_id = ?
    SQL
    rows = self.class.db.execute(sql, self.id)
    rows.collect { |row|
      Student.new_from_db(row)
    }
  end

  def add_student(student)
    Registration.new.tap {|r|
      r.course_id = self.id
      r.student_id = student.id
    }.save
  end
end
