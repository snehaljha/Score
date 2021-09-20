import 'package:Score/Model/Player.dart';

class CountStats {
  String type;
  int count;
  int id;
  String name;
  int appearances;
  Player player;

  CountStats(this.name, this.type, this.count, this.appearances, this.id, this.player);

}