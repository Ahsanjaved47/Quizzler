import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'quiz_core.dart'; // Import QuizBrain
import 'quiz_file.dart'; // Import Question class

void main() => runApp(QuizzlerApp());

class QuizzlerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrain quizBrain = QuizBrain();
  List<Icon> scoreKeeper = [];
  int correctAnswers = 0;
  int totalQuestions = 0;
  bool isAnswering = true;
  Timer? _timer;
  int _secondsRemaining = 5;

  // Timer function to count down 5 seconds for each question
  void startTimer() {
    _timer?.cancel();
    setState(() {
      _secondsRemaining = 5;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          // If time runs out, automatically go to the next question
          nextQuestion();
        }
      });
    });
  }

  // Check if the answer is correct and move to the next question
  void checkAnswer(bool userPickedAnswer) {
    if (!isAnswering) return;

    bool correctAnswer = quizBrain.getCorrectAnswer();
    setState(() {
      totalQuestions++;

      if (userPickedAnswer == correctAnswer) {
        scoreKeeper.add(Icon(Icons.check, color: Colors.green));
        correctAnswers++;
      } else {
        scoreKeeper.add(Icon(Icons.close, color: Colors.red));
      }

      if (quizBrain.isFinished()) {
        // If quiz is finished, show score and reset quiz
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Quiz Finished'),
            content: Text('You scored $correctAnswers out of $totalQuestions'),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    quizBrain.reset();
                    scoreKeeper.clear();
                    correctAnswers = 0;
                    totalQuestions = 0;
                  });
                  Navigator.pop(context);
                },
                child: Text('Restart Quiz'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  SystemNavigator.pop(); // Close the app
                },
                child: Text('Exit'),
              ),
            ],
          ),
        );
      } else {
        quizBrain.nextQuestion();
        startTimer();
      }
    });
  }

  // Next question logic with timer reset
  void nextQuestion() {
    if (quizBrain.isFinished()) return;

    setState(() {
      quizBrain.nextQuestion();
      startTimer();
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Quizzler',style: TextStyle(fontWeight: FontWeight.bold),)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app,size: 25,),
            onPressed: () {
              SystemNavigator.pop(); // Close the app
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.purple.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Question Text Section
              Expanded(
                flex: 3, // Allocate 3/5 of the screen height
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    quizBrain.getQuestionText(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Buttons for True and False
              Expanded(
                flex: 2, // Allocate 2/5 of the screen height for buttons
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: ElevatedButton(
                        onPressed: () => checkAnswer(true),
                        child: Text('True',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          elevation: 5,
                          shadowColor: Colors.greenAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: ElevatedButton(
                        onPressed: () => checkAnswer(false),
                        child: Text('False',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          elevation: 5,
                          shadowColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Time Remaining Text Section
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Text(
                    'Time remaining: $_secondsRemaining seconds',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Cross-Tick icons between Time and Score in Scrollable Row
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: scoreKeeper,
                  ),
                ),
              ),

              // Score Section
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'Score: $correctAnswers / $totalQuestions',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
