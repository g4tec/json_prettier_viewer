import 'package:flutter/material.dart';
import 'package:json_prettier_viewer/json_prettier_row.dart';

class JsonPrettierObject extends StatefulWidget {
  final Map<String, dynamic> object;
  final TextStyle? style;
  final TextStyle? titleStyle;
  final TextStyle? keStyle;
  final TextStyle? valueStyle;
  final String title;
  final bool usePrimaryColor;
  const JsonPrettierObject({
    Key? key,
    required this.object,
    required this.title,
    this.style,
    this.titleStyle,
    this.keStyle,
    this.valueStyle,
    this.usePrimaryColor = true,
  }) : super(key: key);

  @override
  State<JsonPrettierObject> createState() => _JsonPrettierObjectState();
}

class _JsonPrettierObjectState extends State<JsonPrettierObject> {
  bool isExpanded = false;
  List<Widget> _buildRows() {
    final List<Widget> rows = [];
    final List<Widget> subRows = [];

    for (MapEntry entry in widget.object.entries) {
      if (entry.value is Map<String, dynamic>) {
        subRows.add(JsonPrettierObject(
          object: entry.value as Map<String, dynamic>,
          title: entry.key,
          usePrimaryColor: !widget.usePrimaryColor,
          titleStyle: widget.titleStyle,
          style: widget.style,
          keStyle: widget.keStyle,
          valueStyle: widget.valueStyle,
        ));
      } else if (entry.value is List) {
        for (var r in entry.value as List) {
          if (r is Map<String, dynamic>) {
            subRows.add(JsonPrettierObject(
              object: r,
              title: entry.key,
              style: widget.style,
              keStyle: widget.keStyle,
              valueStyle: widget.valueStyle,
              usePrimaryColor: !widget.usePrimaryColor,
              titleStyle: widget.titleStyle,
            ));
          }
        }
      } else {
        rows.add(JsonPrettierViewerRow(
          row: entry,
          style: widget.style,
          keStyle: widget.keStyle,
          valueStyle: widget.valueStyle,
        ));
      }
    }
    return rows + subRows;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() => setState(() => isExpanded = !isExpanded)),
      child: isExpanded
          ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Icon(
                    Icons.expand_more_sharp,
                    color: widget.titleStyle?.color,
                  ),
                  Text(
                    widget.title,
                    style: widget.titleStyle?.copyWith(
                        color: widget.usePrimaryColor
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Column(
                  children: _buildRows(),
                ),
              ),
            ])
          : Expanded(
              child: Row(
                children: [
                  Icon(
                    Icons.expand_less_sharp,
                    color: widget.titleStyle?.color,
                  ),
                  Text(
                    widget.title,
                    style: widget.titleStyle?.copyWith(
                        color: widget.usePrimaryColor
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
            ),
    );
  }
}
