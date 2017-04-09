require 'pry'
require './lib/node.rb'
require './lib/quizmaster.rb'

quiz_master = QuizMaster.new
root = Node.root
quiz_master.quiz_path(root)
