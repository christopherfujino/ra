import 'dart:math' show Random;
import 'progression.dart' show Progression;

sealed class State {}

class StudyingState implements State {
  @override
  String toString() => 'studying';
}

class DeadState implements State {
  const DeadState();

  @override
  String toString() => 'dead';
}

class IdleState implements State {
  const IdleState();

  @override
  String toString() => 'idle';
}

enum Job {
  none;

  @override
  String toString() => switch (this) {
    .none => 'none',
  };
}

enum Species {
  fox,
  mouse,
  cow;

  @override
  String toString() => switch (this) {
    .fox => 'fox',
    .mouse => 'mouse',
    .cow => 'cow',
  };

  static Species random(Random random) {
    final vals = Species.values;
    return vals[random.nextInt(vals.length)];
  }
}

class Hero {
  Hero._(this.name, this.species);

  factory Hero(String name, Random random) {
    final species = Species.values;
    return Hero._(name, species[random.nextInt(species.length)]);
  }

  final String name;
  final Species species;
  final Job job = .none;
  State state = const IdleState();
  double level = 1;
  double _xp = 0;

  double get ratioToNextLevel {
    final nextLevelXp = Progression.forLevels.ofLevel(level.floor() + 1);
    final floorForCurrentLevel = Progression.forLevels.ofLevel(level.floor());
    return (_xp - floorForCurrentLevel) / (nextLevelXp - floorForCurrentLevel);
  }

  double get xp => _xp;
  bool setXp(double newXp) {
    _xp = newXp;
    bool levelledUp = false;

    while (_xp >= Progression.forLevels.ofLevel(level.floor() + 1)) {
      level += 1;
      levelledUp = true;
    }
    return levelledUp;
  }

  double maxHp = 100;
  late double hp = maxHp;
}
