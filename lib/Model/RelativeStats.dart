import 'package:Score/Model/Player.dart';

class RelativeStats {
  String type;
  int count;
  double precentage;
  int id;
  String name;
  String appearance;
  Player player;

  RelativeStats(this.name, this.type, this.count, this.precentage, this.appearance, this.id, this.player);

}