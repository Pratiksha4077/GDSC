
import 'package:flutter/material.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/conversion_card.dart';
import '../utils/unit_data.dart';
import '../services/database_service.dart';
import '../services/api_service.dart';

class ConversionScreen extends StatefulWidget {
  @override
  _ConversionScreenState createState() => _ConversionScreenState();

}

class _ConversionScreenState extends State<ConversionScreen> {
  String selectedCategory = 'Currency';
  String fromUnit = 'USD';
  String toUnit = 'EUR';
  double inputValue = 1.0;
  double result = 0.0;

  Future<void> convert() async {
    final units = unitData[selectedCategory]!;
    final from = units.firstWhere((u) => u.name == fromUnit);
    final to = units.firstWhere((u) => u.name == toUnit);

    try {
      if (selectedCategory == 'Currency') {
        final rate = await ApiService.fetchConversionRate(fromUnit, toUnit);
        setState(() {
          result = inputValue * rate;
        });
      } else if (selectedCategory == 'Temperature') {
        setState(() {
          result = convertTemperature(inputValue, fromUnit, toUnit);
        });
      } else {
        setState(() {
          result = inputValue * from.conversionFactor / to.conversionFactor;
        });
      }

      DatabaseService.addHistory(
        '$inputValue $fromUnit = ${result.toStringAsFixed(2)} $toUnit in $selectedCategory',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Conversion failed: ${e.toString()}')),
      );
    }
  }

  double convertTemperature(double value, String from, String to) {
    if (from == to) return value;

    double celsius;
    if (from == 'Fahrenheit') {
      celsius = (value - 32) * 5 / 9;
    } else if (from == 'Kelvin') {
      celsius = value - 273.15;
    } else {
      celsius = value;
    }

    if (to == 'Fahrenheit') {
      return celsius * 9 / 5 + 32;
    } else if (to == 'Kelvin') {
      return celsius + 273.15;
    } else {
      return celsius;
    }
  }

  @override
  Widget build(BuildContext context) {
    final units = unitData[selectedCategory]!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
        title: Text(
          'Unit Converter',
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade900, Colors.indigo.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              margin: EdgeInsets.only(top: 20),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CustomDropdown(
                      label: 'Category',
                      value: selectedCategory,
                      items: unitData.keys.toList(),
                      onChanged: (value) => setState(() {
                        selectedCategory = value!;
                        fromUnit = unitData[selectedCategory]!.first.name;
                        toUnit = unitData[selectedCategory]!.last.name;
                      }),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: CustomDropdown(
                            label: 'From',
                            value: fromUnit,
                            items: units.map((u) => u.name).toList(),
                            onChanged: (value) => setState(() => fromUnit = value!),
                          ),
                        ),
                        Icon(Icons.swap_horiz, color: Colors.indigo, size: 28),
                        Expanded(
                          child: CustomDropdown(
                            label: 'To',
                            value: toUnit,
                            items: units.map((u) => u.name).toList(),
                            onChanged: (value) => setState(() => toUnit = value!),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Enter value',
                        prefixIcon: Icon(Icons.edit),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onChanged: (val) => setState(() {
                        inputValue = double.tryParse(val) ?? 0;
                      }),
                    ),
                    SizedBox(height: 20),

                    // ✅ Convert Button
                    Center(
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.sync_alt, color: Colors.white),
                        label: Text(
                          'Convert',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 5,
                        ),
                        onPressed: convert,
                      ),
                    ),

                    SizedBox(height: 30),
                    if (result != 0)
                      ConversionCard(
                        resultText:
                        '$inputValue $fromUnit = ${result.toStringAsFixed(2)} $toUnit',
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
