import 'package:flutter/widgets.dart';
import 'globals.dart' as globals;

const toDo = Color(0xFF00FF00);

Widget wrapApp(Widget child) {
  return WidgetsApp(
    color: Color(0xFFFF0000),
    textStyle: TextStyle(
      color: globals.color0,
      fontSize: globals.fontSize,
    ),
    builder: (_, _) => Stack(
      children: <Widget>[
        Container(color: globals.color3),
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
    border: BoxBorder.all(color: globals.color0, width: 1.0),
  ),
  child: child,
);

final tableBorder = TableBorder.all(
  color: globals.color0,
  width: 1.0,
);

Column column(List<Widget> children) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);

Row row(List<Widget> children) => Row(children: children);

Widget button(String label, void Function() onPressed) => GestureDetector(
  onTap: onPressed,
  child: Container(
    margin: EdgeInsetsGeometry.all(_padding / 2),
    color: globals.color0,
    child: padding(
      Text(label, style: TextStyle(color: globals.color3)),
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

Widget text(Object obj, {bool addPadding = true}) =>
    addPadding ? padding(Text(obj.toString())) : Text(obj.toString());
