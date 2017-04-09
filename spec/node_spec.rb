require './spec/spec_helper.rb'

describe "Node" do
  before do
    @root = Node.root
    @question = Node.new(type: "question", data: "Can it fly?")
    @animal1 = Node.new(type: "animal", data: "a mouse")
    @question1 = Node.new(type: "question", data: "Is it small?")
  end
  it "creates a root node of type: 'animal' and data: 'an elephant'" do
    expect(@root.type).to eq("animal")
    expect(@root.data).to eq("an elephant")
  end
  it "stores a node with type and data" do
    expect(@question.type).to eq("question")
    expect(@question.data).to eq("Can it fly?")
  end
  it "stores a node with yes/no attributes to store child nodes" do
    expect(@question.yes).to eq(nil)
    expect(@question.no).to eq(nil)
  end
  context "child nodes" do
    before do
      @root.add_replace(animal: "a mouse", question: "Is it small?", yes_no: "y")
    end
    it "stores two animal nodes, replaces current node with question, animal nodes go on yes/no branches" do
      expect(@root.data).to eq("Is it small?")
      expect(@root.yes.data).to eq("a mouse")
      expect(@root.no.data).to eq("an elephant")
    end
  end
end
