import 'package:flutter/material.dart';

class FormulasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversion Formulas'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),// Navigate back to previous screen
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: ListView(
          children: [
            // Length Conversion Section
            SectionHeader(title: 'Length Conversions'),
            FormulaCard(
              title: 'Millimeter to Centimeter',
              formula: '1 millimeter = 0.1 centimeters',
            ),
            FormulaCard(
              title: 'Centimeter to Meter',
              formula: '1 centimeter = 0.01 meters',
            ),
            FormulaCard(
              title: 'Meter to Kilometer',
              formula: '1 meter = 0.001 kilometers',
            ),
            FormulaCard(
              title: 'Meter to Inch',
              formula: '1 meter = 39.3701 inches',
            ),
            FormulaCard(
              title: 'Meter to Foot',
              formula: '1 meter = 3.28084 feet',
            ),
            FormulaCard(
              title: 'Meter to Yard',
              formula: '1 meter = 1.09361 yards',
            ),
            FormulaCard(
              title: 'Meter to Mile',
              formula: '1 meter = 0.000621371 miles',
            ),
            FormulaCard(
              title: 'Meter to Nautical Mile',
              formula: '1 meter = 0.000539957 nautical miles',
            ),

            // Temperature Conversion Section
            SectionHeader(title: 'Temperature Conversions'),
            FormulaCard(
              title: 'Celsius to Fahrenheit',
              formula: '°F = (°C × 9/5) + 32',
            ),
            FormulaCard(
              title: 'Fahrenheit to Celsius',
              formula: '°C = (°F - 32) × 5/9',
            ),
            FormulaCard(
              title: 'Celsius to Kelvin',
              formula: 'K = °C + 273.15',
            ),
            FormulaCard(
              title: 'Kelvin to Celsius',
              formula: '°C = K - 273.15',
            ),
            FormulaCard(
              title: 'Fahrenheit to Kelvin',
              formula: 'K = (°F - 32) × 5/9 + 273.15',
            ),
            FormulaCard(
              title: 'Kelvin to Fahrenheit',
              formula: '°F = (K - 273.15) × 9/5 + 32',
            ),

            // Currency Conversion Section
            SectionHeader(title: 'Currency Conversions'),
            FormulaCard(
              title: 'USD to EUR',
              formula: 'Amount in EUR = Amount in USD × Conversion Rate',
            ),
            FormulaCard(
              title: 'USD to INR',
              formula: 'Amount in INR = Amount in USD × Conversion Rate',
            ),
            FormulaCard(
              title: 'USD to JPY',
              formula: 'Amount in JPY = Amount in USD × Conversion Rate',
            ),
            FormulaCard(
              title: 'USD to GBP',
              formula: 'Amount in GBP = Amount in USD × Conversion Rate',
            ),
            FormulaCard(
              title: 'EUR to USD',
              formula: 'Amount in USD = Amount in EUR × Conversion Rate',
            ),
            FormulaCard(
              title: 'INR to USD',
              formula: 'Amount in USD = Amount in INR × Conversion Rate',
            ),
            FormulaCard(
              title: 'JPY to USD',
              formula: 'Amount in USD = Amount in JPY × Conversion Rate',
            ),
            FormulaCard(
              title: 'GBP to USD',
              formula: 'Amount in USD = Amount in GBP × Conversion Rate',
            ),
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      ),
    );
  }
}

class FormulaCard extends StatelessWidget {
  final String title;
  final String formula;

  const FormulaCard({
    required this.title,
    required this.formula,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              formula,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
