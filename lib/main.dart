import 'package:flutter/widgets.dart' as fl;
import 'ui.dart' as ui;
import 'game.dart' show GameWidget;

void main() {
  fl.runApp(ui.wrapApp(const GameWidget()));
}
