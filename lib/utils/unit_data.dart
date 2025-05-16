import '../models/unit_model.dart';

final Map<String, List<UnitModel>> unitData = {
  'Length': [
    UnitModel(name: 'Millimeter', conversionFactor: 0.001, category: 'Length'),
    UnitModel(name: 'Centimeter', conversionFactor: 0.01, category: 'Length'),
    UnitModel(name: 'Meter', conversionFactor: 1.0, category: 'Length'),
    UnitModel(name: 'Kilometer', conversionFactor: 1000.0, category: 'Length'),
    UnitModel(name: 'Inch', conversionFactor: 0.0254, category: 'Length'),
    UnitModel(name: 'Foot', conversionFactor: 0.3048, category: 'Length'),
    UnitModel(name: 'Yard', conversionFactor: 0.9144, category: 'Length'),
    UnitModel(name: 'Mile', conversionFactor: 1609.34, category: 'Length'),
    UnitModel(name: 'Nautical Mile', conversionFactor: 1852.0, category: 'Length'),
  ],

  'Width': [
    UnitModel(name: 'Millimeter', conversionFactor: 0.001, category: 'Width'),
    UnitModel(name: 'Centimeter', conversionFactor: 0.01, category: 'Width'),
    UnitModel(name: 'Meter', conversionFactor: 1.0, category: 'Width'),
    UnitModel(name: 'Kilometer', conversionFactor: 1000.0, category: 'Width'),
    UnitModel(name: 'Inch', conversionFactor: 0.0254, category: 'Width'),
    UnitModel(name: 'Foot', conversionFactor: 0.3048, category: 'Width'),
    UnitModel(name: 'Yard', conversionFactor: 0.9144, category: 'Width'),
  ],

  'Temperature': [
    UnitModel(name: 'Celsius', conversionFactor: 1.0, category: 'Temperature'),
    UnitModel(name: 'Fahrenheit', conversionFactor: 1.0, category: 'Temperature'),
    UnitModel(name: 'Kelvin', conversionFactor: 1.0, category: 'Temperature'),
  ],

  'Currency': [
    UnitModel(name: 'USD', conversionFactor: 1, category: 'Currency'),
    UnitModel(name: 'EUR', conversionFactor: 1, category: 'Currency'),
    UnitModel(name: 'INR', conversionFactor: 1, category: 'Currency'),
    UnitModel(name: 'GBP', conversionFactor: 1, category: 'Currency'),
    UnitModel(name: 'JPY', conversionFactor: 1, category: 'Currency'),
  ],
  // other categories...
};
