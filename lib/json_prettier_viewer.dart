library json_prettier_viewer;

import 'package:flutter/material.dart';
import 'package:json_prettier_viewer/json_prettier_object.dart';
import 'package:json_prettier_viewer/json_prettier_row.dart';

class JsonPrettierViewer extends StatefulWidget {
  final Map<String, dynamic> json;
  final TextStyle? style;
  final TextStyle? titleStyle;
  final TextStyle? keStyle;
  final TextStyle? valueStyle;
  final EdgeInsets? margin;
  const JsonPrettierViewer(
      {Key? key,
      this.margin,
      required this.json,
      this.style,
      this.keStyle,
      this.valueStyle,
      this.titleStyle})
      : super(key: key);

  @override
  State<JsonPrettierViewer> createState() => _JsonPrettierViewerState();
}

class _JsonPrettierViewerState extends State<JsonPrettierViewer> {
  List<Widget> _buildRows() {
    final List<Widget> rows = [];

    if (widget.json.entries.first is! List) {
      return [
        JsonPrettierObject(
          object: widget.json,
          title: "",
          style: widget.style,
          keStyle: widget.keStyle,
          valueStyle: widget.valueStyle,
          titleStyle: widget.titleStyle,
        )
      ];
    }

    for (var row in widget.json.entries) {
      if (row.value is List) {
        for (var r in row.value as List) {
          if (r is Map<String, dynamic>) {
            rows.add(JsonPrettierObject(
              object: r,
              title: row.key,
              style: widget.style,
              keStyle: widget.keStyle,
              valueStyle: widget.valueStyle,
              titleStyle: widget.titleStyle,
            ));
          } else {
            rows.add(JsonPrettierViewerRow(
              row: r,
              style: widget.style,
              keStyle: widget.keStyle,
              valueStyle: widget.valueStyle,
            ));
          }
        }
      }
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: widget.margin,
      child: Column(
        children: _buildRows(),
      ),
    );
  }
}
