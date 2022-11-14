//

// ignore_for_file: depend_on_referenced_packages

import 'package:connect_database/helpers/routing/nav_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../connection_manager/connection_manager_bloc/connection_manager_bloc.dart';
import '../../connection_manager/models/connection_manager_textfield_type.dart';
import '../../widgets/main_widgets.dart';

class ExecutingSqlScreen extends StatefulWidget {
  const ExecutingSqlScreen({super.key});

  @override
  State<ExecutingSqlScreen> createState() => _ExecutingSqlScreenState();
}

class _ExecutingSqlScreenState extends State<ExecutingSqlScreen> {
  void _handleRecordes(
    BuildContext context,
    List<Map<String, String>> records,
  ) {
    records.forEach((element) {
      print(element);
    });
    Navigator.of(context).pushNamed(Navlinks.sqlResult, arguments: records);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectionManagerBloc, ConnectionManagerState>(
      listener: (context, state) {
        if (state is ConnectionManagerSuccess) {
          _handleRecordes(context, state.records);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                SizedBox(height: 32),
                ConnectionManagerTextField(
                    type: ConnectionManagerTextFieldType.host),
                SizedBox(height: 16),
                ConnectionManagerTextField(
                    type: ConnectionManagerTextFieldType.port),
                SizedBox(height: 16),
                ConnectionManagerTextField(
                    type: ConnectionManagerTextFieldType.database),
                SizedBox(height: 16),
                ConnectionManagerTextField(
                    type: ConnectionManagerTextFieldType.username),
                SizedBox(height: 16),
                ConnectionManagerTextField(
                    type: ConnectionManagerTextFieldType.password),
                SizedBox(height: 16),
                ConnectionManagerTextField(
                    type: ConnectionManagerTextFieldType.query),
                SizedBox(height: 32),
                ConnectionBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
