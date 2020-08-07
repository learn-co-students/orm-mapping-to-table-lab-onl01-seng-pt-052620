class Student
  attr_reader :id
  attr_accessor :name, :grade

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
    def initialize (name, grade)
      @name = name
      @grade = grade
    end

    def self.create_table
      sql = <<-SQL
        CREATE TABLE IF NOT EXISTS students (
          id INTEGER PRIMARY KEY,
          name TEXT,
          grade TEXT
        )
        SQL
      DB[:conn].execute(sql)
    end

    def self.drop_table
      sql = "DROP TABLE IF EXISTS students"
      DB[:conn].execute(sql)
    end

    def save
      sql = "INSERT INTO students (name, grade) VALUES (?, ?)"
      DB[:conn].execute(sql, self.name, self.grade)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students") [0][0]
    end

    def self.create (attributes) #attributes = hash of attributes 
      student = self.new(attributes[:name], attributes[:grade]) #passes name and grade keys/values of the hash to create new instances of Student Class and saves return value in local variable
      student.save  #student local variable is an instance of student. Runs save method on that instance creating entry in the db
      student #returns the student instance which is needed for the test to pass
    end




  

  
  
end
