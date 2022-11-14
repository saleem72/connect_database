//

// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../connection_manager/connection_manager_bloc/connection_manager_bloc.dart';
import '../helpers/styling/styling.dart';

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
              SizedBox(
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
    } else {
      return const SizedBox.shrink();
    }
  }
}
