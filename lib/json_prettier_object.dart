import 'package:flutter/material.dart';
import 'package:json_prettier_viewer/json_prettier_row.dart';

class JsonPrettierObject extends StatefulWidget {
  final Map<String, dynamic> object;
  final TextStyle? style;
  final TextStyle? titleStyle;
  final TextStyle? keStyle;
  final TextStyle? valueStyle;
  final String? title;
  final bool usePrimaryColor;
  const JsonPrettierObject({
    Key? key,
    required this.object,
    this.title,
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
  List<Widget> _buildRows({bool justFirst = false}) {
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
          keStyle: justFirst
              ? widget.titleStyle?.copyWith(
                  color: widget.usePrimaryColor
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).colorScheme.secondary,
                )
              : widget.keStyle,
          valueStyle: widget.valueStyle,
        ));
      } else if (entry.value is List) {
        for (var r in entry.value as List) {
          if (r is Map<String, dynamic>) {
            subRows.add(JsonPrettierObject(
              object: r,
              style: widget.style,
              keStyle: justFirst
                  ? widget.titleStyle?.copyWith(
                      color: widget.usePrimaryColor
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.secondary,
                    )
                  : widget.keStyle,
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
          valueStyle: widget.valueStyle,
          keStyle: justFirst
              ? widget.titleStyle?.copyWith(
                  color: widget.usePrimaryColor
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).colorScheme.secondary,
                )
              : widget.keStyle,
        ));
      }
      if (justFirst) {
        if ((rows).isNotEmpty) {
          return rows;
        }
      }
    }
    if (justFirst && (rows).isEmpty) {
      return [
        Text(
          widget.title ?? " - ",
          style: widget.titleStyle?.copyWith(
            color: widget.usePrimaryColor
                ? Theme.of(context).primaryColor
                : Theme.of(context).colorScheme.secondary,
          ),
        )
      ];
    }
    return (rows.isNotEmpty && widget.title == null ? rows.sublist(1) : rows) +
        subRows;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = _buildRows();
    Widget? rowTitle = _buildRows(justFirst: true).first;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: (() => setState(() => isExpanded = !isExpanded)),
        child: isExpanded
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      rows.isNotEmpty
                          ? Icon(
                              Icons.expand_more_sharp,
                              color: widget.titleStyle?.color,
                            )
                          : const SizedBox(
                              width: 24,
                            ),
                      Expanded(
                        child: widget.title != null
                            ? Text(
                                widget.title!,
                                style: widget.titleStyle?.copyWith(
                                  color: widget.usePrimaryColor
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).colorScheme.secondary,
                                ),
                              )
                            : rowTitle,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: rows,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rows.isNotEmpty
                      ? Icon(
                          Icons.expand_less_sharp,
                          color: widget.titleStyle?.color,
                        )
                      : const SizedBox(
                          width: 24,
                        ),
                  Flexible(
                    child: widget.title != null
                        ? Text(
                            widget.title!,
                            style: widget.titleStyle?.copyWith(
                              color: widget.usePrimaryColor
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).colorScheme.secondary,
                            ),
                          )
                        : rowTitle,
                  ),
                ],
              ),
      ),
    );
  }
}
