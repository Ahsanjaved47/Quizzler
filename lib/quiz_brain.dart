import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question('Some cats are actually allergic to humans', true),
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
    Question('Buzz Aldrin\'s mother\'s maiden name was "Moon".', true),
    Question('It is illegal to pee in the Ocean in Portugal.', true),
    Question('No piece of square dry paper can be folded in half more than 7 times.', false),
    Question('In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.', true),
    Question('The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.', false),
    Question('The total surface area of two human lungs is approximately 70 square meters.', true),
    Question('Google was originally called "Backrub".', true),
    Question('Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.', true),
    Question('In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.', true),
    Question('Some fish can live in both salt and fresh water.', true),
    Question('The shortest commercial flight in the world is only 47 seconds long.', true),
    Question('There are more trees on Earth than stars in the Milky Way galaxy.', true),
    Question('Humans share 60% of their DNA with bananas.', true),
    Question('Sharks are older than trees.', true),
    Question('A giraffe’s tongue is purple.', true),
    Question('The Eiffel Tower can be 15 cm taller during the summer due to thermal expansion of the metal.', true),
    Question('Bananas are berries, but strawberries are not.', true),
    Question('The longest hiccuping spree lasted for 68 years.', true),
    Question('Wombat poop is cube-shaped to prevent it from rolling away.', true),
    Question('A day on Venus is longer than a year on Venus.', true),
    Question('Octopuses have three hearts.', true),
    Question('Honey never spoils. Archaeologists have found pots of honey in ancient Egyptian tombs that are over 3,000 years old and still edible.', true),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    return _questionNumber == _questionBank.length - 1;
  }

  void reset() {
    _questionNumber = 0;
  }
}
