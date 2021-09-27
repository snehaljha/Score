import 'package:Score/Model/MatchScore.dart';
import 'package:Score/Model/category.dart';

import 'Team.dart';

class Match implements Comparable {
  Category category;
  int statusCode;
  Team homeTeam;
  Team awayTeam;
  MatchScore? homeScore;
  MatchScore? awayScore;
  int id;
  int startTimestamp;

  Match(this.category, this.statusCode, this.homeTeam, this.awayTeam,
      this.homeScore, this.awayScore, this.id, this.startTimestamp);

  @override
  int compareTo(other) {
    if (this.startTimestamp < other.startTimestamp) return -1;
    if (this.startTimestamp > other.startTimestamp) return 1;
    if (this.homeTeam.userCount + this.awayTeam.userCount >
        other.homeTeam.userCount + other.awayTeam.userCount) return -1;
    if (this.homeTeam.userCount + this.awayTeam.userCount >
        other.homeTeam.userCount + other.awayTeam.userCount) return 1;
    return 0;
  }

  String getCurrentScore() {
    if (homeScore == null || awayScore == null) return "-";
    return homeScore!.current.toString() +
        " - " +
        awayScore!.current.toString();
  }
}
