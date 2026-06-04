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
  double xp = 0;
  (double, double) get levelRemainder =>
      Progression.forLevels.getLevelRemainder(xp);

  double hp = 100;
}
