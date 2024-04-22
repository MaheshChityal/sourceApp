class Batsman {
  String name;
  int runs;
  int balls;
  int fours;
  int sixes;
  
  Batsman({
    required this.name,
    required this.runs,
    required this.balls,
    required this.fours,
    required this.sixes,
  });
  
  double strikeRate() {
    if (balls == 0) return 0.0;
    return (runs / balls) * 100;
  }
}