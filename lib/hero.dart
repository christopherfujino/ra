sealed class HeroState {
  void update();
}

class StudyingState implements HeroState {
  @override
  void update() {}

  @override
  String toString() => 'studying';
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
