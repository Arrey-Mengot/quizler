import 'package:flutter/material.dart';
import 'questionbrain.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(Quizler());
}

class Quizler extends StatelessWidget {
  const Quizler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('QuiiZler'),
            centerTitle: true,
          ),
          body: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

List<Icon> results = [];

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              onPressed: () {
                setState(() {
                  if (quizBrain.isFinished()) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('ALERT!'),
                            content: Text('End of quiz.Click to restart'),
                            actions: <Widget>[
                              ElevatedButton(
                                  onPressed: quizBrain.quizReset(),
                                  child: Text('RESTART'))
                            ],
                          );
                        });
                    results = [];
                  } else {
                    bool correct = true;
                    if (quizBrain.getCorrectAnswer() == correct) {
                      results.add(Icon(Icons.check));
                    } else {
                      results.add(Icon(Icons.close));
                    }

                    quizBrain.nextQuestion();
                  }
                });
              },
              child: Text(
                'TRUE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  if (quizBrain.isFinished()) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('ALERT!'),
                            content: Text('End of quiz.Click to restart'),
                            actions: <Widget>[
                              ElevatedButton(
                                  onPressed: quizBrain.quizReset(),
                                  child: Text('RESTART'))
                            ],
                          );
                        });
                    results = [];
                  } else {
                    bool correct = false;
                    if (quizBrain.getCorrectAnswer() == correct) {
                      results.add(Icon(Icons.check));
                    } else {
                      results.add(Icon(Icons.close));
                    }

                    quizBrain.nextQuestion();
                  }
                });
              },
              child: Text(
                'FALSE',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        Row(
          children: results,
        )
      ],
    );
  }
}
