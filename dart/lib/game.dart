import 'dart:collection' show Queue;
import 'dart:math' show Random;
import 'package:flutter/widgets.dart' as fl;
import 'clock.dart';
import 'hero.dart';
import 'view.dart';

class GameWidget extends fl.StatefulWidget {
  const GameWidget({super.key});

  @override
  Game createState() => Game();
}

class Lore {
  final lore = Queue<String>();
  static const _maxLore = 12;

  void add(String s) {
    lore.add(s);
    if (lore.length > _maxLore) {
      lore.removeFirst();
    }
  }
}

class Game extends fl.State<GameWidget> {
  @override
  void initState() {
    super.initState();

    clock.start();
  }

  int nextInt(int x) => random.nextInt(x);
  double nextDouble() => random.nextDouble();
  List<T> shuffle<T extends Object>(List<T> original) {
    final size = original.length;
    final List<T?> workspace = [...original];
    final output = <T>[];
    for (int i = 0; i < size; i++) {
      T? t;
      int idx = nextInt(size);
      while ((t = workspace[idx]) == null) {
        idx++;
        if (idx >= size) {
          idx = 0;
        }
      }
      output.add(t!);
      workspace[idx] = null;
    }
    return output;
  }

  final random = Random();

  // this should only be called by the clock!
  void _clockTick() {
    setState(() {
      for (final hero in heroes) {
        if (hero.state case DeadState()) {
          continue;
        }
        hero.hp -= 0.1;
        if (hero.hp <= 0) {
          hero.hp = 0;
          lore.add('${hero.name} has died of hunger.');
          hero.state = const DeadState();
        }
      }

      if (heroes
              .where(
                (hero) => switch (hero.state) {
                  DeadState() => false,
                  _ => true,
                },
              )
              .firstOrNull ==
          null) {
        lore.add('All your heroes are dead!');
        clock.stop();
      }
    });
  }

  void updateHeroXpBy(Hero hero, double xpDiff) {
    setState(() {
      if (hero.setXp(hero.xp + 1)) {
        final level = hero.level.floor();
        lore.add('${hero.name} levelled up: ${level - 1} => $level');
      }
    });
  }

  void updateHeroState(Hero hero, State nextState) {
    setState(() {
      if (nextState case DeadState()) {
        hero.state = nextState;
        return;
      }
      switch (hero.state) {
        case IdleState():
          hero.state = nextState;
        default:
          lore.add(
            '${hero.name} is ${hero.state}, they must be idle to start $nextState',
          );
      }
    });
  }

  late final heroes = shuffle([
    'Bill',
    'Betty',
    'Barbara',
    'Bob',
  ]).map((name) => Hero(name, random)).toList();

  final lore = Lore()..add('Your quest has begun.');

  late final Clock clock = Clock(() => _clockTick());

  View _view = const DefaultView();
  void updateView(View nextView) => setState(() => _view = nextView);

  @override
  fl.Widget build(_) => _view.build(this);
}
