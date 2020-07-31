class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize (name, grade)
    
    @name = name;
    @grade = grade;

  end

  def self.create_table 

    sql = <<-SQL
            CREATE TABLE IF NOT EXISTS students (
              id INTEGER PRIMARY KEY,
              name TEXT,
              grade INT); 
              SQL

    DB[:conn].execute(sql);

  end

  def self.drop_table

    sql = <<-SQL
            DROP TABLE IF EXISTS students;
            SQL

    DB[:conn].execute(sql)

  end

  def save

    sql = <<-SQL
            INSERT INTO students (name, grade)
              VALUES (?, ?);
              SQL

    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]

  end

  def self.create (attributes)

    student = self.new(attributes[:name], attributes[:grade])
    attributes.each do |attribute_key, attribute_value|
      student.send("#{attribute_key}=", attribute_value)
    end
    student.save
    student

  end

end
