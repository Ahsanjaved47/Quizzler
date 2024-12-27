import 'quiz_file.dart';

class QuizBrain {
  int _questionNumber = 0;

  List<Questionfile> _questionBank = [
    Questionfile('Some cats are actually allergic to humans', true),
    Questionfile('You can lead a cow down stairs but not up stairs.', false),
    Questionfile('Approximately one quarter of human bones are in the feet.', true),
    Questionfile('A slug\'s blood is green.', true),
    Questionfile('Buzz Aldrin\'s mother\'s maiden name was "Moon".', true),
    Questionfile('It is illegal to pee in the Ocean in Portugal.', true),
    Questionfile('No piece of square dry paper can be folded in half more than 7 times.', false),
    Questionfile('In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.', true),
    Questionfile('The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.', false),
    Questionfile('The total surface area of two human lungs is approximately 70 square meters.', true),
    Questionfile('Google was originally called "Backrub".', true),
    Questionfile('Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.', true),
    Questionfile('In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.', true),
    Questionfile('Some fish can live in both salt and fresh water.', true),
    Questionfile('The shortest commercial flight in the world is only 47 seconds long.', true),
    Questionfile('There are more trees on Earth than stars in the Milky Way galaxy.', true),
    Questionfile('Humans share 60% of their DNA with bananas.', true),
    Questionfile('Sharks are older than trees.', true),
    Questionfile('A giraffe’s tongue is purple.', true),
    Questionfile('The Eiffel Tower can be 15 cm taller during the summer due to thermal expansion of the metal.', true),
    Questionfile('Bananas are berries, but strawberries are not.', true),
    Questionfile('The longest hiccuping spree lasted for 68 years.', true),
    Questionfile('Wombat poop is cube-shaped to prevent it from rolling away.', true),
    Questionfile('A day on Venus is longer than a year on Venus.', true),
    Questionfile('Octopuses have three hearts.', true),
    Questionfile('Honey never spoils. Archaeologists have found pots of honey in ancient Egyptian tombs that are over 3,000 years old and still edible.', true),
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
