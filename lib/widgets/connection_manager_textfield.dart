//

// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../connection_manager/connection_manager_bloc/connection_manager_bloc.dart';
import '../connection_manager/models/connection_manager_textfield_type.dart';
import '../helpers/styling/styling.dart';

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
      constraints: const BoxConstraints(
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
