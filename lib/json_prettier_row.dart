import 'package:flutter/material.dart';

class JsonPrettierViewerRow extends StatelessWidget {
  final MapEntry row;
  final TextStyle? style;
  final TextStyle? keStyle;
  final TextStyle? valueStyle;
  final String? separator;
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
    return RichText(
        textAlign: TextAlign.start,
        text: TextSpan(children: [
          TextSpan(text: row.key, style: keStyle ?? style),
          TextSpan(text: separator ?? ": ", style: keStyle ?? style),
          TextSpan(text: row.value.toString(), style: valueStyle ?? style),
        ]));
  }
}
