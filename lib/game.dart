import 'dart:collection' show Queue;
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

  void update() {
    for (final hero in heroes) {
      if (hero.state case DeadState()) {
        continue;
      }
      hero.hp -= 1;
      if (hero.hp <= 0) {
        hero.hp = 0;
        lore.add('${hero.name} has died of hunger.');
        updateHeroState(hero, const DeadState());
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
  }

  void updateView(View nextView) {
    setState(() => view = nextView);
  }

  void updateHeroState(Hero hero, State nextState) {
    if (nextState case DeadState()) {
      hero.state = nextState;
      return;
    }
    switch (hero.state) {
      case IdleState():
        hero.state = nextState;
      default:
        lore.add(
          '${hero.name} is ${hero.state}, they must be idle to start ${nextState}',
        );
    }
  }

  final heroes = [
    'Bill',
    'Betty',
    'Barbara',
    'Bob',
  ].map((name) => Hero(name: name)).toList();

  final lore = Lore()
    ..add('Your quest has begun.');

  late final Clock clock = Clock(() {
    setState(() {
      update();
    });
  });

  View view = DefaultView();

  @override
  fl.Widget build(_) => view.build(this);
}
