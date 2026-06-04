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
    double left = amount;
    double level = 0;
    double remainder = 0;
    while(amount > 0) {

    }
    return (level, remainder);
  }

  static final forLevels = Progression(10, 100, 2.0);
}
