require 'active_record'
require './lib/task'
require './lib/list'

database_configuration = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configuration["development"]
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "Welcome to the To Do list!"
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "Press 'a' to add a task, 'l' to list your tasks, or 'd' to mark a task as done."
    puts "Press 'e' to exit."
    choice = gets.chomp
    case choice
    when 'a'
      add
    when 'd'
      mark_done
    when 'l'
      list
    when 'e'
      puts "Good-bye!"
    else
      puts "Sorry, I don't understand your choice."
    end
  end
end

def add
  puts "What do you want to do?"
  task_name = gets.chomp
  task = Task.new(:name => task_name, :done => false)
  task.save
  puts "'#{task.name}' has been added to your To Do list."
end

def list
  puts "Here is everything you need to do:"
  tasks = Task.not_done
  tasks.each { |task| puts task.name }
end

def mark_done
  puts "Which of these tasks would you like to mark as done?"
  Task.not_done.each { |task| puts task.name }
  done_task_name = gets.chomp
  done_task = Task.where(:name => done_task_name).first
  done_task.update_attributes(:done => true)
end

welcome
