import 'package:Score/Model/Player.dart';

class CountStats {
  String type;
  int count;
  int id;
  String name;
  String appearance;
  Player player;

  CountStats(this.name, this.type, this.count, this.appearance, this.id, this.player);

}