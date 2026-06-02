import 'package:flutter/widgets.dart';

const foregroundColor = Color(0xFF000000);
const backgroundColor = Color(0xFFFFFFFF);
const linkColor = Color(0xFF00FFFF);
const double fontSize = 20;
const toDo = Color(0xFF00FF00);

Widget wrapApp(Widget child) {
  return WidgetsApp(
    color: Color(0xFFFF0000),
    textStyle: TextStyle(color: foregroundColor, fontSize: fontSize),
    builder: (_, _) => Stack(
      children: <Widget>[
        Container(color: backgroundColor),
        child,
      ],
    ),
  );
}

const double _padding = 6.0;

Padding padding(Widget child, {double padding = _padding}) =>
    Padding(padding: EdgeInsetsGeometry.all(padding), child: child);

Container border(Widget child) => Container(
  decoration: BoxDecoration(
    border: BoxBorder.all(color: foregroundColor, width: 1.0),
  ),
  child: child,
);

final tableBorder = TableBorder.all(color: foregroundColor, width: 1.0);

Column column(List<Widget> children) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);

Widget button(String label, {required void Function() onPressed}) =>
    GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsetsGeometry.all(_padding / 2),
        color: foregroundColor,
        child: padding(
          Text(label, style: TextStyle(color: backgroundColor)),
          padding: _padding / 2,
        ),
      ),
    );

Widget table(List<List<Widget>> rawRows) {
  final rows = rawRows.map((row) {
    final cells = row.map((widget) => TableCell(child: widget));
    return TableRow(children: cells.toList());
  });

  return padding(
    Align(
      alignment: AlignmentGeometry.topLeft,
      child: Table(
        defaultColumnWidth: const IntrinsicColumnWidth(),
        border: tableBorder,
        children: rows.toList(),
      ),
    ),
  );
}

Widget text(String label, {bool addPadding = true}) =>
    addPadding ? padding(Text(label)) : Text(label);
