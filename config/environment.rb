require 'bundler'
Bundler.require   #required all gems 

require_relative '../lib/student'

DB = {:conn => SQLite3::Database.new("db/students.db")}
