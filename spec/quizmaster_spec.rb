require './spec/spec_helper.rb'

describe "Quiz Master" do

  YES = "y\n"
  NO = "n\n"
  PLAIN_ELEPHANT = "an elephant"
  PLAIN_RABBIT = "a rabbit"
  PLAIN_SMALL_OR_NOT = "Is it a small animal? (y or n)"
  RABBIT = "a rabbit\n"
  SMALL_OR_NOT = "Is it a small animal?\n"
  SMALL_OR_NOT_ANSWER = "y\n"
  ANIMAL_QUESTION = "Is it an elephant? (y or n)"
  WHAT_DISTINGUISHES = "Give me a question to distinguish a rabbit from an elephant."
  WHAT_DISTINGUISHES_ANSWER = "For a rabbit, what is the answer to your question? (y or n)"

  let(:output_interface) {StringIO.new}
  let(:input_interface) {StringIO.new}
  let(:root) {Node.root}
  let(:question) {Node.new(type: "question", data: "Is it a small animal?")}

  subject do
    QuizMaster.new(output_interface: output_interface, input_interface: input_interface)
  end

  it "should ask the player to think of an animal" do
    subject.start
    expect(output_interface.string).to include(QuizMaster::START_MESSAGE)
  end

  it "should gloat" do
    subject.gloat
    expect(output_interface.string).to include(QuizMaster::GLOAT_MESSAGE)
  end

  describe "#animal?" do
    let(:input_interface) {StringIO.new(YES)}
    before do
      subject.animal?(root)
    end
    it "should ask the player if he/she is thinking of an elelphant" do
      expect(output_interface.string).to include(ANIMAL_QUESTION)
    end
  end

  describe "#question?" do
    let(:input_interface) {StringIO.new(NO)}
    before do
      subject.question?(question)
    end
    it "should ask the player if the animal is small or not" do
      expect(output_interface.string).to include(PLAIN_SMALL_OR_NOT)
    end

  end

  describe "#quiz_path" do
    context "take the player through the quiz path" do
      let(:input_interface) {StringIO.new(NO + RABBIT + SMALL_OR_NOT + SMALL_OR_NOT_ANSWER + NO)}
      before do
        subject.quiz_path(root)
      end
      it "should start the quiz" do
        expect(output_interface.string).to include(QuizMaster::START_MESSAGE)
      end
      it "should ask the player if the animal is correct" do
        expect(output_interface.string).to include(QuizMaster::ANIMAL_QUESTION)
      end
      it "should ask the player for help" do
        expect(output_interface.string).to include(QuizMaster::HELP_ME_MESSAGE)
      end
      it "should ask the player questions about new animal" do
        expect(output_interface.string).to include(QuizMaster::WHAT_ANIMAL)
        expect(output_interface.string).to include(WHAT_DISTINGUISHES)
        expect(output_interface.string).to include(WHAT_DISTINGUISHES_ANSWER)
      end
      it "should ask the player if he/she wants to play again" do
        expect(output_interface.string).to include(QuizMaster::PLAY_AGAIN_MESSAGE)
      end
    end
  end

  describe "#thinking_of?" do
    let(:input_interface) {StringIO.new(RABBIT + SMALL_OR_NOT + SMALL_OR_NOT_ANSWER)}
    before do
      subject.thinking_of?(root)
    end
    it "should ask the player what animal they were thinking of" do
      expect(output_interface.string).to include(QuizMaster::WHAT_ANIMAL)
    end
    it "should ask the player a question to distinguish the animal from the previous animal" do
      expect(output_interface.string).to include(WHAT_DISTINGUISHES)
    end
    it "should ask the player what the answer is to the previous question" do
      expect(output_interface.string).to include(WHAT_DISTINGUISHES_ANSWER)
    end
  end

  describe "#play_again?" do
    context "ask the player if he/she wants to play again" do
      let(:input_interface) {StringIO.new(YES + NO + RABBIT + SMALL_OR_NOT + SMALL_OR_NOT_ANSWER + NO)}
      before do
        subject.play_again?(root)
      end
      it "should restart the quiz if the player enters 'y'" do
        expect(output_interface.string).to include(QuizMaster::START_MESSAGE)
      end
    end
  end

end
