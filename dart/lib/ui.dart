import 'dart:math' show min;
import 'package:flutter/widgets.dart' as fl;
import 'globals.dart' as globals;

const toDo = fl.Color(0xFF00FF00);

fl.Widget wrapApp(fl.Widget child) {
  return fl.WidgetsApp(
    color: fl.Color(0xFFFF0000),
    textStyle: fl.TextStyle(color: globals.color0, fontSize: globals.fontSize),
    builder: (_, _) => fl.Stack(
      children: <fl.Widget>[
        fl.Container(color: globals.color3),
        child,
      ],
    ),
  );
}

const double _padding = 6.0;

fl.Padding padding(fl.Widget child, {double padding = _padding}) =>
    fl.Padding(padding: fl.EdgeInsetsGeometry.all(padding), child: child);

fl.Container border(fl.Widget child) => fl.Container(
  decoration: fl.BoxDecoration(
    border: fl.BoxBorder.all(color: globals.color0, width: 1.0),
  ),
  child: child,
);

final tableBorder = fl.TableBorder.all(color: globals.color0, width: 1.0);

fl.Column column(List<fl.Widget> children) => fl.Column(
  crossAxisAlignment: fl.CrossAxisAlignment.start,
  children: children,
);

fl.Row row(List<fl.Widget> children) => fl.Row(children: children);

fl.Widget button(String label, void Function() onPressed) => fl.GestureDetector(
  onTap: onPressed,
  child: fl.Container(
    margin: fl.EdgeInsetsGeometry.all(_padding / 2),
    color: globals.color0,
    child: padding(
      fl.Text(label, style: fl.TextStyle(color: globals.color3)),
      padding: _padding / 2,
    ),
  ),
);

fl.Widget table(List<List<fl.Widget>> rawRows) {
  final rows = rawRows.map((row) {
    final cells = row.map((widget) => fl.TableCell(child: widget));
    return fl.TableRow(children: cells.toList());
  });

  return padding(
    fl.Align(
      alignment: fl.AlignmentGeometry.topLeft,
      child: fl.Table(
        defaultColumnWidth: const fl.IntrinsicColumnWidth(),
        border: tableBorder,
        children: rows.toList(),
      ),
    ),
  );
}

fl.Widget text(Object obj, {bool addPadding = true}) =>
    addPadding ? padding(fl.Text(obj.toString())) : fl.Text(obj.toString());

class ProgressBarPainter extends fl.CustomPainter {
  const ProgressBarPainter(this.ratio);

  final double ratio;
  static final _paint = fl.Paint()..color = globals.color2;

  @override
  void paint(fl.Canvas canvas, fl.Size size) {
    canvas.drawRect(
      fl.Rect.fromLTWH(0, 0, min(size.width * ratio, size.width), size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(covariant fl.CustomPainter oldDelegate) {
    return (oldDelegate as ProgressBarPainter).ratio != ratio;
  }
}

fl.Widget progressBar(double ratio, String label) {
  return fl.CustomPaint(
    painter: ProgressBarPainter(ratio),
    child: padding(fl.Text(label)),
  );
}
