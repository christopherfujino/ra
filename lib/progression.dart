class Progression {
  Progression(int levels, double initialThreshold, double multiplier) {
    double nextThreshold = initialThreshold;
    for (int i = 0; i < levels; i++) {
      _thresholds.add(nextThreshold);
      nextThreshold *= multiplier;
    }
  }

  late final List<double> _thresholds = [];

  double ofLevel(int level) => _thresholds[level - 1];

  double levelOf(double amount) {
    int level = 1;
    while (amount >= _thresholds[level - 1]) {
      level += 1;
    }

    return level.toDouble();
  }

  //static final forLevels = Progression(10, 100, 2.0);
  static final forLevels = Progression(10, 10, 3.5);
}
