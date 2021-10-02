import 'package:Score/Model/Team.dart';
import 'package:Score/constants.dart';

class Player {
  String name;
  String slug;
  String shortName;
  String position;
  int userCount;
  int id;
  Team team;
  late String photo;
  String? preferredFoot;
  int? shirtNumber;

  Player(this.name, this.slug, this.shortName, this.id, this.position,
      this.userCount, this.team) {
    this.photo =
        (position == "coach" ? Constants.managerPhoto : Constants.playerPhoto)
            .replaceFirst("{player_id}", id.toString());
  }

  Player.forSquadList(
      this.name,
      this.slug,
      this.shortName,
      this.id,
      this.position,
      this.userCount,
      this.team,
      this.preferredFoot,
      this.shirtNumber) {
    this.photo =
        Constants.playerPhoto.replaceFirst("{player_id}", id.toString());
  }
}
