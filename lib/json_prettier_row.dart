import 'package:flutter/material.dart';

class JsonPrettierViewerRow extends StatelessWidget {
  final MapEntry row;
  final TextStyle? style;
  final TextStyle? keStyle;
  final TextStyle? valueStyle;
  final Widget? separator;
  const JsonPrettierViewerRow({
    Key? key,
    required this.row,
    this.style,
    this.keStyle,
    this.valueStyle,
    this.separator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${row.key}',
          style: keStyle ?? style,
        ),
        separator ?? const Text(": "),
        Text('${row.value}', style: valueStyle ?? style),
      ],
    );
  }
}
