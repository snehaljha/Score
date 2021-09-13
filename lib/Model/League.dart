import 'package:Score/constants.dart';

class League {
  String name = "name";
  String slug = "slug";
  int userCount = 0;
  int id = -1;
  late String leagueLogoUrl;

  League(this.name, this.slug, this.id, this.userCount) {
    this.leagueLogoUrl = getLogoUrl();
  }

  String getLogoUrl() {
    String url = Constants.leagueLogo;
    return url.replaceFirst("{league_id}", id.toString());
  }
}
