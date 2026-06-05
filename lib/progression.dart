class Progression {
  Progression(int levels, double initialThreshold, double multiplier) {
    double nextThreshold = initialThreshold;
    for (int i = 0; i < levels; i++) {
      _thresholds.add(nextThreshold);
      nextThreshold *= multiplier;
    }
    print(_thresholds);
  }

  late final List<double> _thresholds = [];

  (double, double) getLevelRemainder(double amount) {
    int level = 1;
    while (amount > _thresholds[level]) {
      level += 1;
    }

    return (level.toDouble(), _thresholds[level] - amount);
  }

  static final forLevels = Progression(10, 100, 2.0);
}
