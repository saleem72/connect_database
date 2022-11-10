//

import 'dart:ui';

import 'package:connect_database/connection_manager/connection_manager.dart';
import 'package:connect_database/screens/sql_result_sreen/sql_result_sreen.dart';
import 'package:connect_database/styling/pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'connection_manager/connection_manager_bloc/connection_manager_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Pallet.appBarSwatch,
          scaffoldBackgroundColor: Pallet.background // Colors.blue,
          ),
      home: BlocProvider(
        create: (context) => ConnectionManagerBloc(
          host: 'epsilondemo.dyndns.org',
          port: '1433',
          database: 'amndbtest1',
          username: 'sa',
          password: 'H123456789h',
          query: 'SELECT * FROM mt000',
          connectionManager: ConnectionManager(),
        ),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _handleRecordes(
      BuildContext context, List<Map<String, String>> records) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SqlResultScreen(records: records),
      ),
    );
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

class AppTextField extends StatelessWidget {
  const AppTextField(
      {Key? key,
      required this.controller,
      required this.label,
      required this.hint,
      this.labelWidth = 70,
      this.textStyle})
      : super(key: key);
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextStyle? textStyle;
  final double labelWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SizedBox(
            width: labelWidth,
            child: Text(
              label,
              style: textStyle ??
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: textStyle ??
                    Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade400,
                        ),
                isCollapsed: true,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ConnectionManagerTextField extends StatefulWidget {
  const ConnectionManagerTextField({
    Key? key,
    required this.type,
    this.labelWidth = 70,
    this.textStyle,
  }) : super(key: key);
  final ConnectionManagerTextFieldType type;
  final double labelWidth;
  final TextStyle? textStyle;

  @override
  State<ConnectionManagerTextField> createState() =>
      _ConnectionManagerTextFieldState();
}

class _ConnectionManagerTextFieldState
    extends State<ConnectionManagerTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _initController(context);
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _initController(context);
  // }

  void _initController(BuildContext context) {
    final connectionManager = context.read<ConnectionManagerBloc>();
    switch (widget.type) {
      case ConnectionManagerTextFieldType.host:
        _controller = TextEditingController(text: connectionManager.host);
        break;
      case ConnectionManagerTextFieldType.port:
        _controller = TextEditingController(text: connectionManager.port);
        break;
      case ConnectionManagerTextFieldType.database:
        _controller = TextEditingController(text: connectionManager.database);
        break;
      case ConnectionManagerTextFieldType.username:
        _controller = TextEditingController(text: connectionManager.username);
        break;
      case ConnectionManagerTextFieldType.password:
        _controller = TextEditingController(text: connectionManager.password);
        break;
      case ConnectionManagerTextFieldType.query:
        _controller = TextEditingController(text: connectionManager.query);
        break;
    }
  }

  void _updateBloc(BuildContext context) {
    final connectionManager = context.read<ConnectionManagerBloc>();
    switch (widget.type) {
      case ConnectionManagerTextFieldType.host:
        connectionManager
            .add(ConnectionManagerHostHasChange(host: _controller.text));
        break;
      case ConnectionManagerTextFieldType.port:
        connectionManager
            .add(ConnectionManagerPortHasChange(port: _controller.text));
        break;
      case ConnectionManagerTextFieldType.database:
        connectionManager.add(
            ConnectionManagerDatabaseHasChange(database: _controller.text));
        break;
      case ConnectionManagerTextFieldType.username:
        connectionManager.add(
            ConnectionManagerUsernameHasChange(username: _controller.text));
        break;
      case ConnectionManagerTextFieldType.password:
        connectionManager.add(
            ConnectionManagerPasswordHasChange(password: _controller.text));
        break;
      case ConnectionManagerTextFieldType.query:
        connectionManager
            .add(ConnectionManagerQueryHasChange(query: _controller.text));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<ConnectionManagerBloc>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
      child: Row(
        children: [
          SizedBox(
            width: widget.labelWidth,
            child: Text(
              widget.type.label,
              style: widget.textStyle ??
                  Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Pallet.green // Colors.grey.shade600,
                          ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              style: widget.textStyle ?? Theme.of(context).textTheme.bodyMedium,
              onChanged: (value) => _updateBloc(context),
              decoration: InputDecoration(
                hintText: widget.type.label,
                hintStyle: widget.textStyle ??
                    Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade400,
                        ),
                isCollapsed: true,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum ConnectionManagerTextFieldType {
  host,
  port,
  database,
  username,
  password,
  query
}

extension ConnectionManagerTextFieldTypeDetails
    on ConnectionManagerTextFieldType {
  String get label {
    switch (this) {
      case ConnectionManagerTextFieldType.host:
        return 'Host';
      case ConnectionManagerTextFieldType.port:
        return 'Port';
      case ConnectionManagerTextFieldType.database:
        return 'Database';
      case ConnectionManagerTextFieldType.username:
        return 'Username';
      case ConnectionManagerTextFieldType.password:
        return 'Password';
      case ConnectionManagerTextFieldType.query:
        return 'Query';
    }
  }
}

class ConnectionBar extends StatelessWidget {
  const ConnectionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionManagerBloc, ConnectionManagerState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: _blocStatus(context, state)),
              Container(
                height: 100,
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () => executeQuery(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                          color: Pallet.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Connect',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => executeIsolateQuery(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                          color: Pallet.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Isolate',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void executeQuery(BuildContext context) {
    context.read<ConnectionManagerBloc>().add(ConnectionManagerConnect());
  }

  void executeIsolateQuery(BuildContext context) {
    context
        .read<ConnectionManagerBloc>()
        .add(ConnectionManagerIsolatedConnect());
  }

  Widget _blocStatus(BuildContext context, ConnectionManagerState state) {
    if (state is ConnectionManagerLoading) {
      print('We are loading now');
      return const CircularProgressIndicator();
    } else if (state is ConnectionManagerFailure) {
      return Text(
        state.failure.message,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.redAccent,
            ),
      );
      // } else if (state is ConnectionManagerSuccess) {
      //   return Text(
      //     state.message,
      //     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      //           color: Colors.green,
      //         ),
      //   );
    } else {
      return const SizedBox.shrink();
    }
  }
}
