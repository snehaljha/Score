import 'package:Score/Model/Team.dart';

class StandingItem implements Comparable {
  Team team;
  int position;
  int matches;
  int wins;
  int losses;
  int draws;
  int scoresFor;
  int scoresAgainst;
  int points;
  int id;

  StandingItem(this.team, this.position, this.matches, this.wins, this.losses,
      this.draws, this.scoresFor, this.scoresAgainst, this.points, this.id);

  @override
  int compareTo(other) {
    if (this.position < other.position)
      return -1;
    else if (this.position > other.position) return 1;
    return 0;
  }
}
