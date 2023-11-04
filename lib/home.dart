import 'dart:math';
import 'package:flutter/material.dart';

class LoanCalculator extends StatefulWidget {
  @override
  _LoanCalculatorState createState() => _LoanCalculatorState();
}

class _LoanCalculatorState extends State<LoanCalculator> {
  double loanAmount = 0.0;
  int loanTerm = 0;
  double interestRate = 0.0;
  double monthlyPayment = 0.0;

  final TextEditingController amountController = TextEditingController();
  final TextEditingController termController = TextEditingController();
  final TextEditingController interestController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loan Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Loan Amount',
              ),
            ),
            TextField(
              controller: termController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Loan Term (months)',
              ),
            ),
            TextField(
              controller: interestController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Interest Rate (%)',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  loanAmount = double.parse(amountController.text);
                  loanTerm = int.parse(termController.text);
                  interestRate = double.parse(interestController.text);
                  calculateMonthlyPayment();
                });
              },
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            Text(
              'Monthly Payment: \$${monthlyPayment.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  void calculateMonthlyPayment() {
    if (loanAmount != 0 && loanTerm != 0 && interestRate != 0) {
      double monthlyInterest = interestRate / 100 / 12;
      int numberOfPayments = loanTerm;
      num temp = pow(1 + monthlyInterest, numberOfPayments);
      monthlyPayment = (loanAmount * temp * monthlyInterest) / (temp - 1);
    } else {
      monthlyPayment = 0.0;
    }
  }
}
