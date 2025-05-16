import 'package:flutter/material.dart';
import '../services/database_service.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final history = DatabaseService.getHistory();

    return Scaffold(
      appBar: AppBar(
        title: Text('Conversion History'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        leading: IconButton(
        icon: Icon(Icons.arrow_back),
        tooltip: 'Back',
        onPressed: () => Navigator.pushReplacementNamed(context, '/home'),// Navigate back to previous screen
        ),
      ),
      body: history.isEmpty
          ? Center(
        child: Text(
          'No conversion history yet!',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final entry = history[index];
          final record = entry['record']!;
          final timestamp = entry['timestamp']!;

          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(Icons.history, color: Colors.indigo),
              title: Text(
                record,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(timestamp),
              trailing: Icon(Icons.chevron_right),
            ),
          );
        },
      ),
    );
  }
}
