import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arifmetik Mashqlar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ArithmeticPage(),
    );
  }
}

class ArithmeticPage extends StatefulWidget {
  @override
  _ArithmeticPageState createState() => _ArithmeticPageState();
}

class _ArithmeticPageState extends State<ArithmeticPage> {
  int firstNumber = 0;
  int secondNumber = 0;
  String operator = '';
  int correctAnswer = 0;

  TextEditingController userAnswerController = TextEditingController();
  String resultText = '';

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  void generateQuestion() {
    Random random = Random();
    firstNumber = random.nextInt(1000) + 1;
    secondNumber = random.nextInt(1000) + 1;

    List<String> operators = ['+', '-', '*'];
    operator = operators[random.nextInt(operators.length)];

    double result;
    if (operator == '+') {
      result = (firstNumber + secondNumber).toDouble();
    } else if (operator == '-') {
      result = (firstNumber - secondNumber).toDouble();
    } else {
      result = (firstNumber * secondNumber).toDouble();
    } 
    correctAnswer = result.toInt();
  }

  void checkAnswer() {
    int userAnswer = int.parse(userAnswerController.text);

    if (userAnswer == correctAnswer) {
      resultText = 'To\'g\'ri javob!';
    } else {
      resultText = 'Noto\'g\'ri javob! To\'g\'ri javob: $correctAnswer';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Arifmetik Mashqlar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Qaysi amalni bajarish kerak?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '$firstNumber $operator $secondNumber = ?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: userAnswerController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Javobni kiriting',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  checkAnswer();
                  generateQuestion();
                  userAnswerController.clear();
                });
              },
              child: Text('Tekshirish'),
            ),
            SizedBox(height: 20),
            Text(
              resultText,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}