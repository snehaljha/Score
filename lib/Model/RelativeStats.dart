import 'package:Score/Model/Player.dart';

class RelativeStats {
  String type;
  int count;
  double precentage;
  int id;
  String name;
  int appearances;
  Player player;

  RelativeStats(this.name, this.type, this.count, this.precentage, this.appearances, this.id, this.player);

}