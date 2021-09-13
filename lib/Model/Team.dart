import 'package:Score/constants.dart';

class Team {
  String name;
  String slug;
  String shortName;
  int userCount;
  String nameCode;
  int id;
  late String teamLogo;

  Team(this.name, this.id, this.slug, this.shortName, this.nameCode, this.userCount) {
    this.teamLogo = Constants.teamLogo.replaceFirst("{team_id}", this.id.toString());
  }
}