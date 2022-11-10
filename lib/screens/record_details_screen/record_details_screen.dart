//

import 'package:flutter/material.dart';

import '../../styling/pallet.dart';

class RecordDetailsScreen extends StatelessWidget {
  const RecordDetailsScreen({
    Key? key,
    required this.record,
  }) : super(key: key);
  final Map<String, String> record;
  @override
  Widget build(BuildContext context) {
    final recordKeys = record.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record details'),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          itemCount: record.keys.length,
          itemBuilder: (context, index) {
            return Container(
              height: 66,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.only(bottom: 8),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recordKeys[index],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Pallet.green,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    record[recordKeys[index]] ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
