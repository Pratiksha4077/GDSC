import 'package:intl/intl.dart';

class DatabaseService {
  static final List<Map<String, String>> _history = [];
  static final List<String> _favorites = [];

  static void addHistory(String record) {
    final now = DateTime.now();
    final formatted = DateFormat('MMM dd, yyyy – hh:mm a').format(now);
    _history.add({
      'record': record,
      'timestamp': formatted,
    });
  }

  static List<Map<String, String>> getHistory() => _history;

  static void addFavorite(String record) {
    if (!_favorites.contains(record)) {
      _favorites.add(record);
    }
  }

  static List<String> getFavorites() => _favorites;
}
