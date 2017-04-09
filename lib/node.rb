class Node

  attr_accessor :type, :data, :yes, :no

  def initialize(type: nil, data: nil, yes: nil, no: nil)
    @type = type
    @data = data
    @yes = yes
    @no = no
  end

  def self.root
    self.new(type: "animal", data: "an elephant")
  end

  def add_replace(animal: new_animal, question: new_question, yes_no: new_yes_no)
    new_animal_node = Node.new(type: "animal", data: animal)
    old_animal_node = Node.new(type: "animal", data: self.data)
    if yes_no == "y"
      self.yes = new_animal_node
      self.no = old_animal_node
    else
      self.no = new_animal_node
      self.yes = old_animal_node
    end
    self.type = "question"
    self.data = question
  end

end
