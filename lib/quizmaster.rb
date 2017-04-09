class QuizMaster

  attr_reader :output_interface, :input_interface

  START_MESSAGE = "Think of an animal..."
  HELP_ME_MESSAGE = "You win. Help me learn from my mistakes before you go..."
  GLOAT_MESSAGE =   "I win. Pretty smart, aren't I?"
  WHAT_ANIMAL = "What animal were you thinking of?"
  PLAY_AGAIN_MESSAGE = "Play again? (y or n)"
  BYE_MESSAGE = "Bye"

  def initialize(output_interface: STDOUT, input_interface: STDIN)
    @output_interface = output_interface
    @input_interface = input_interface
  end

  def start
    self.output_interface.puts START_MESSAGE
  end

  def gloat
    self.output_interface.puts GLOAT_MESSAGE
  end

  def animal?(animal)
    self.output_interface.puts "Is it " + animal.data + "? (y or n)"
    answer = self.input_interface.gets.chomp
  end

  def question?(question)
    self.output_interface.puts question.data + " (y or n)"
    answer = self.input_interface.gets.chomp
  end

  def quiz_path(node)
    root = node
    self.start
    loop do
      if node.type == "animal"
        if self.animal?(node) == "y"
          self.gloat
          break_out = true
        else
          values = self.thinking_of?(node)
          node.add_replace(animal: values[:animal], question: values[:question], yes_no: values[:answer])
          break_out = true
        end
      else
        self.question?(node) == "y" ? node = node.yes : node = node.no
      end
      break if break_out
    end
    self.play_again?(root)
  end

  def thinking_of?(animal)
    self.output_interface.puts HELP_ME_MESSAGE
    self.output_interface.puts WHAT_ANIMAL
    new_animal = self.input_interface.gets.chomp
    self.output_interface.puts "Give me a question to distinguish " + new_animal + " from " + animal.data + "."
    new_question = self.input_interface.gets.chomp
    self.output_interface.puts "For " + new_animal + ", what is the answer to your question? (y or n)"
    new_answer = self.input_interface.gets.chomp
    return {animal: new_animal, question: new_question, answer: new_answer}
  end

  def play_again?(root)
    self.output_interface.puts PLAY_AGAIN_MESSAGE
    answer = self.input_interface.gets.chomp
    answer == "y" ? self.quiz_path(root) : return
  end

end
