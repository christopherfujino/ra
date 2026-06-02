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

class Hero {
  Hero({required this.name});

  final String name;
  State state = const IdleState();
  int level = 1;
  int xp = 0;
  int hp = 100;
}
