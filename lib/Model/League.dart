import 'package:Score/Model/Season.dart';
import 'package:Score/constants.dart';

class League implements Comparable{
  String name = "";
  String slug = "";
  int userCount = 0;
  int id = -1;
  late String leagueLogoUrl;
  List<Season>? seasons = null;

  League(this.name, this.slug, this.id, this.userCount) {
    if(this.userCount == null) this.userCount = 0;
    this.leagueLogoUrl = getLogoUrl();
  }

  String getLogoUrl() {
    String url = Constants.leagueLogo;
    return url.replaceFirst("{league_id}", id.toString());
  }

  @override
  int compareTo(other) {
    if(this.userCount > other.userCount) return -1;
    if(this.userCount < other.userCount) return 1;
    return this.name.compareTo(other.name);
  }
}
