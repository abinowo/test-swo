import 'package:flutter/material.dart';

class TableItem extends StatelessWidget {
  final String sym, last, chg, chg2;

  const TableItem({
    super.key,
    required this.sym,
    required this.last,
    required this.chg,
    required this.chg2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              sym,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              last,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              chg,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              chg2,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
