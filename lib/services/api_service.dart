class ApiService {
  static Future<double> fetchConversionRate(String from, String to) async {
    await Future.delayed(Duration(milliseconds: 500));

    // Bi-directional mock exchange rates
    final Map<String, Map<String, double>> mockRates = {
      'USD': {'EUR': 0.9, 'INR': 83.0, 'GBP': 0.8, 'JPY': 110.0},
      'EUR': {'USD': 1.1, 'INR': 92.0, 'GBP': 0.88, 'JPY': 123.0},
      'INR': {'USD': 0.012, 'EUR': 0.011, 'GBP': 0.0096, 'JPY': 1.5},
      'GBP': {'USD': 1.25, 'EUR': 1.14, 'INR': 104.0, 'JPY': 140.0},
      'JPY': {'USD': 0.0091, 'EUR': 0.0081, 'INR': 0.67, 'GBP': 0.0071},

    };

    double? rate = mockRates[from]?[to];

    if (rate != null) return rate;

    // If direct rate not found, try reverse and invert
    double? reverseRate = mockRates[to]?[from];
    if (reverseRate != null) return 1 / reverseRate;

    // Default fallback
    return 1.0;
  }

  static Future<List<double>> fetchHistoricalRates(String from, String to) async {
    await Future.delayed(Duration(milliseconds: 300));

    // Simple mock 7-day history
    return List.generate(7, (i) => (1 + i * 0.01) * ((from.hashCode + to.hashCode) % 10 + 1));
  }
}
