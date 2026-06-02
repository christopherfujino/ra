import 'dart:collection' show Queue;

import 'package:flutter/widgets.dart' as fl;
import 'ui.dart' as ui;
import 'clock.dart';
import 'view.dart';
import 'hero.dart';

void main() {
  fl.runApp(ui.wrapApp(const GameWidget()));
}

class Lore {
  final lore = Queue<String>();
  static const _maxLore = 5;

  void add(String s) {
    lore.add(s);
    if (lore.length > _maxLore) {
      lore.removeFirst();
    }
  }
}

class GameWidget extends fl.StatefulWidget {
  const GameWidget({super.key});

  @override
  Game createState() => Game();
}

class Game extends fl.State<GameWidget> {
  @override
  void initState() {
    super.initState();

    clock.start();
  }

  void updateView(View nextView) {
    setState(() => view = nextView);
  }

  void study(Hero hero) {
    switch (hero.state) {
      case IdleState():
        hero.state = StudyingState();
      default:
        lore.add('${hero.name} is ${hero.state}, they cannot study now');
    }
  }

  final heroes = [
    'Bill',
    'Betty',
    'Barbara',
    'Bob',
  ].map((name) => Hero(name: name)).toList();

  final lore = Lore()
    ..add('initial')
    ..add('follow-up')
    ..add('tertiary');

  late final Clock clock = Clock(() {
    setState(() {
      //lore.add('tick = ${100.0 / clock.tick}');
    });
  });

  View view = DefaultView();

  @override
  fl.Widget build(_) => view.build(this);
}
