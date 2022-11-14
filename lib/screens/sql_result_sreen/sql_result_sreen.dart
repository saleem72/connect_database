//

import 'package:connect_database/helpers/routing/nav_links.dart';
import 'package:connect_database/models/material_datails.dart';
import 'package:flutter/material.dart';

import '../../helpers/styling/styling.dart';
import '../../widgets/app_material_card.dart';

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
      body: Column(
        children: [
          // Expanded(
          //   flex: 1,
          //   child: ListView.builder(
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          //       itemCount: records.length,
          //       itemBuilder: (context, index) {
          //         return GestureDetector(
          //           onTap: () {
          //             Navigator.of(context).pushNamed(Navlinks.recordDetails,
          //                 arguments: records[index]);
          //             // Navigator.of(context).push(
          //             //   MaterialPageRoute(
          //             //     builder: (context) =>
          //             //         RecordDetailsScreen(record: records[index]),
          //             //   ),
          //             // );
          //           },
          //           child: Container(
          //             padding: const EdgeInsets.symmetric(
          //                 vertical: 8, horizontal: 16),
          //             margin: const EdgeInsets.only(bottom: 16),
          //             constraints: const BoxConstraints(
          //               minHeight: 44,
          //             ),
          //             decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.circular(12),
          //               border: Border.all(
          //                 color: Colors.black.withOpacity(0.4),
          //                 width: 0.5,
          //               ),
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.black.withOpacity(0.25),
          //                   blurRadius: 4,
          //                   offset: const Offset(2, 2),
          //                 ),
          //               ],
          //             ),
          //             alignment: Alignment.centerLeft,
          //             child: Text(
          //               'Record: ${index + 1}',
          //               style: Theme.of(context).textTheme.bodyLarge,
          //             ),
          //           ),
          //         );
          //       }),
          // ),
          const SizedBox(height: 32),
          Expanded(
            // flex: 2,
            child: _buildMaterialCard(context, records),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialCard(
      BuildContext context, List<Map<String, String>> recoreds) {
    final materials = recoreds.map((e) => MaterialDetails.fromMap(e)).toList();

    return AppMaterialCard(materials: materials);
  }
}
