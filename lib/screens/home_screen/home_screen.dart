//

import 'package:connect_database/helpers/routing/nav_links.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            _HomeScreenButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Navlinks.executingSql);
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => const ExecutingSqlScreen()));
              },
              label: 'Execute sql statment',
              backgroundColor: Colors.purple,
            ),
            const SizedBox(height: 16),
            _HomeScreenButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Navlinks.barcodeScan);
              },
              label: 'Scan barcode',
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeScreenButton extends StatelessWidget {
  const _HomeScreenButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.foregroundColor = Colors.white,
    this.backgroundColor = Colors.blue,
  }) : super(key: key);
  final String label;
  final Function onPressed;
  final Color foregroundColor;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: foregroundColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
