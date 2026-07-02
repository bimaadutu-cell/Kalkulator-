import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _input = '';
  String _result = '';
  String _operator = '';
  double _firstOperand = 0;

  void _onButtonPressed(String value) {
    setState(() {
      if (_isDigit(value) || value == '.') {
        _input += value;
      } else if (_isOperator(value)) {
        if (_input.isNotEmpty) {
          _firstOperand = double.parse(_input);
          _operator = value;
          _input = '';
        }
      } else if (value == '=') {
        if (_input.isNotEmpty && _operator.isNotEmpty) {
          double secondOperand = double.parse(_input);
          _result = _calculate(_firstOperand, secondOperand, _operator).toString();
          _input = '';
          _operator = '';
        }
      } else if (value == 'C') {
        _input = '';
        _result = '';
        _operator = '';
        _firstOperand = 0;
      }
    });
  }

  bool _isDigit(String val) => RegExp(r'^\d$').hasMatch(val);
  bool _isOperator(String val) => ['+', '-', 'x', '/'].contains(val);

  double _calculate(double a, double b, String op) {
    switch (op) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case 'x':
        return a * b;
      case '/':
        return a / b;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      _input.isEmpty ? _result : _input,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildButtonRow(['7', '8', '9', '/']),
          _buildButtonRow(['4', '5', '6', 'x']),
          _buildButtonRow(['1', '2', '3', '-']),
          _buildButtonRow(['C', '0', '=', '+']),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Row(
      children: buttons.map((label) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.all(1),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _isOperator(label) || label == 'C' || label == '='
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: () => _onButtonPressed(label),
              child: Text(
                label,
                style: TextStyle(fontSize: 24