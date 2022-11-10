//

import 'package:connect_database/screens/record_details_screen/record_details_screen.dart';
import 'package:flutter/material.dart';

class SqlResultScreen extends StatelessWidget {
  const SqlResultScreen({
    Key? key,
    required this.records,
  }) : super(key: key);
  final List<Map<String, String>> records;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sql Result'),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          itemCount: records.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        RecordDetailsScreen(record: records[index]),
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                margin: const EdgeInsets.only(bottom: 16),
                constraints: BoxConstraints(
                  minHeight: 44,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.4),
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Record: ${index + 1}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            );
          }),
    );
  }
}
