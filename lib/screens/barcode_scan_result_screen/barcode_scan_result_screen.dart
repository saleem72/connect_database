// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:connect_database/connection_manager/connection_manager_bloc/connection_manager_bloc.dart';
import 'package:connect_database/helpers/routing/nav_links.dart';
import 'package:connect_database/helpers/sql_statements.dart';

import '../../models/material_datails.dart';
import '../../widgets/app_material_card.dart';

class BarcodeScanResult extends StatefulWidget {
  const BarcodeScanResult({Key? key, required this.barcode}) : super(key: key);
  final String barcode;

  @override
  State<BarcodeScanResult> createState() => _BarcodeScanResultState();
}

class _BarcodeScanResultState extends State<BarcodeScanResult> {
  @override
  void initState() {
    super.initState();
    _callConnectionManager();
  }

  void _callConnectionManager() {
    final connectionManager = context.read<ConnectionManagerBloc>();
    connectionManager.add(
      ConnectionManagerQueryHasChange(
        query: SQLStatements.barcodeExample,
        // query: SQLStatements.statementForBarcode(widget.barcode),
      ),
    );
    connectionManager.add(ConnectionManagerConnect());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan result'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 32),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSpinner(context),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.barcode,
            style: Theme.of(context).textTheme.labelLarge,
          )
        ],
      ),
    );
  }

  Widget _buildSpinner(BuildContext context) {
    // final connectionManager = context.read<ConnectionManagerBloc>();
    return BlocBuilder<ConnectionManagerBloc, ConnectionManagerState>(
      builder: (context, state) {
        if (state is ConnectionManagerLoading) {
          return const SizedBox(
            height: 75,
            width: 75,
            child: CircularProgressIndicator(),
          );
        } else if (state is ConnectionManagerSuccess) {
          final records = state.records;
          if (records.isNotEmpty) {
            // Navigator.of(context)
            //     .pushNamed(Navlinks.sqlResult, arguments: records);

            // return const SizedBox.shrink();
            return _buildMaterialCard(context, records);
          } else {
            return Text(
              'No results found',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w600,
                  ),
            );
          }
        } else if (state is ConnectionManagerFailure) {
          return Text(
            state.failure.message,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.redAccent,
                ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildMaterialCard(
      BuildContext context, List<Map<String, String>> recoreds) {
    final materials = recoreds.map((e) => MaterialDetails.fromMap(e)).toList();

    return AppMaterialCard(materials: materials);
  }
}
