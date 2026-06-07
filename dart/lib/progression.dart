class Progression {
  Progression(int levels, double initialThreshold, double multiplier) {
    double nextThreshold = initialThreshold;
    for (int i = 0; i < levels; i++) {
      _thresholds.add(nextThreshold);
      nextThreshold *= multiplier;
    }
  }

  late final List<double> _thresholds = [];

  double ofLevel(int level) => switch (level) {
    1 => 0,
    _ => _thresholds[level - 2],
  };

  static final forLevels = Progression(10, 10, 4);
}
