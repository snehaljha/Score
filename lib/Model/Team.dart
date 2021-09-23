import 'package:Score/constants.dart';

class Team {
  String name;
  String slug;
  String shortName;
  int userCount;
  String nameCode;
  int id;
  late String teamLogo;
  late bool favourite;

  Team(this.name, this.id, this.slug, this.shortName, this.nameCode,
      this.userCount) {
    this.favourite = false;
    this.teamLogo =
        Constants.teamLogo.replaceFirst("{team_id}", this.id.toString());
  }

  Team.favourite(this.name, this.id, this.slug, this.shortName, this.nameCode,
      this.userCount, this.favourite) {
    this.teamLogo =
        Constants.teamLogo.replaceFirst("{team_id}", this.id.toString());
  }
}
