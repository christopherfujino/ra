import 'dart:async' show Timer;
import 'dart:collection' show Queue;

import 'package:flutter/material.dart';
import 'ui.dart' as ui;

void main() {
  runApp(ui.wrapApp(const GameWidget()));
}

sealed class HeroState {
  void update();
}

class IdleState implements HeroState {
  const IdleState();

  @override
  void update() {
    // no-op
  }

  @override
  String toString() => 'idle';
}

class Hero {
  Hero({required this.name});

  final String name;
  HeroState state = const IdleState();
  int level = 1;
  int xp = 0;
  int hp = 100;
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

enum Season {
  winter,
  spring,
  summer,
  autumn;

  @override
  String toString() => switch (this) {
    winter => 'winter',
    spring => 'spring',
    summer => 'summer',
    autumn => 'autumn',
  };
}

enum TimeOfDay {
  night,
  day;

  @override
  String toString() => switch (this) {
    night => 'night',
    day => 'day',
  };
}

class Clock {
  Clock(this.callback);

  final void Function() callback;
  int tick = 0;
  Season season = .winter;
  TimeOfDay timeOfDay = .night;
  int days = 0;
  int hours = 0;
  int minutes = 0;

  static const _tickInterval = Duration(milliseconds: 500);
  Timer? _timer;

  void _nativeCallback(Timer _) {
    tick += 1;
    final daysDouble = tick.toDouble() / 100.0;
    days = daysDouble.floor();
    season = switch (days) {
      < 60 => .winter,
      < 150 => .spring,
      < 240 => .summer,
      < 330 => .autumn,
      _ => .winter,
    };
    final hoursDouble = (daysDouble - days) * 24;
    hours = hoursDouble.floor();

    timeOfDay = switch (hours) {
      < 18 && > 6 => .day,
      _ => .night,
    };
    final minutesDouble = (hoursDouble - hours) * 60;
    minutes = minutesDouble.floor();
    callback();
  }

  void start() {
    _timer = Timer.periodic(_tickInterval, _nativeCallback);
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  String get time {
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} ($timeOfDay) of day ${days + 1} $season';
  }
}

sealed class View {
  Widget build(Game game);
}

class HeroView implements View {
  HeroView(this.hero);

  final Hero hero;

  @override
  Widget build(Game game) {
    return ui.column(
      children: <Widget>[
        Text('View of ${hero.name}'),
        ui.button(
          'Return',
          onPressed: () => game.updateView(const DefaultView()),
        ),
      ],
    );
  }
}

class DefaultView implements View {
  const DefaultView();

  @override
  Widget build(Game game) {
    final globalStatus = <Widget>[
      ui.padding(
        Table(
          border: ui.tableBorder,
          children: <TableRow>[
            TableRow(
              children: <TableCell>[
                TableCell(child: ui.padding(Text(game.clock.time))),
              ],
            ),
          ],
        ),
      ),
    ];

    final heroStatus = <Widget>[
      ui.padding(Text('Heroes:')),
      ui.padding(
        Table(
          children: game.heroes
              .map(
                (hero) => TableRow(
                  children: <Widget>[
                    TableCell(
                      child: ui.button(
                        hero.name,
                        onPressed: () => game.updateView(HeroView(hero)),
                      ),
                    ),
                    TableCell(child: ui.padding(Text("Level: ${hero.level}"))),
                    TableCell(child: ui.padding(Text("XP: ${hero.xp}"))),
                    TableCell(child: ui.padding(Text("HP: ${hero.hp}"))),
                    TableCell(child: ui.padding(Text(hero.state.toString()))),
                  ],
                ),
              )
              .toList(),
          columnWidths: <int, TableColumnWidth>{
            // name
            0: const IntrinsicColumnWidth(),
            // level
            1: const IntrinsicColumnWidth(),
            // xp
            2: const IntrinsicColumnWidth(),
            // hp
            3: const IntrinsicColumnWidth(),
          },
          border: ui.tableBorder,
        ),
      ),
    ];

    final loreStatus = <Widget>[
      ui.padding(const Text('Lore:')),
      ui.padding(
        ui.border(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: game.lore.lore.map((s) => ui.padding(Text(s))).toList(),
          ),
        ),
      ),
    ];

    return ui.column(
      children: <Widget>[...globalStatus, ...heroStatus, ...loreStatus],
    );
  }
}

class GameWidget extends StatefulWidget {
  const GameWidget({super.key});

  @override
  Game createState() => Game();
}

class Game extends State<GameWidget> {
  @override
  void initState() {
    super.initState();

    clock.start();
  }

  void updateView(View nextView) {
    setState(() => view = nextView);
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
  Widget build(BuildContext _) => view.build(this);
}
