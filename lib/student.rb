class Student
  attr_reader :id 
  attr_accessor :name, :grade
  
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  


  def initialize(name, grade)
    @name = name 
    @grade = grade 
  end 

  def self.create_table 
   sql = "CREATE TABLE IF NOT EXISTS students(  
      id INTEGER PRIMARY KEY, 
      name TEXT, 
      grade TEXT 
    )"
  DB[:conn].execute(sql)
  end 

  def self.create(attributes)
    student = self.new(attributes[:name], attributes[:grade]) 
    student.save 
  end 

 # attributes.each do |attribute_name, attribute_value| 
    #   student.send("#{attribute_name}=", self.attribute_value)
    # end



  # def self.create(attributes = {})
  #   name = attributes[:name]
  #   grade = attributes[:grade] 
  #   DB[:conn].execute(name, grade) 
  # end 

  def self.drop_table 
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end 
  
  def save
    sql = "INSERT INTO students (name, grade) VALUES (?, ?)"
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    self 
  end
end
