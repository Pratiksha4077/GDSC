import 'package:flutter/material.dart';

class ConversionCard extends StatelessWidget {
  final String resultText;

  ConversionCard({required this.resultText});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          resultText,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }


}
