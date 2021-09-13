import 'package:Score/constants.dart';

class Category implements Comparable {
  late String name;
  late String slug;
  late int priority;
  late int id;
  late String flag;
  late String alpha2;
  late String flagUrl;

  Category(
      this.name, this.slug, this.id, this.priority, this.flag, this.alpha2) {
    if (alpha2 != null)
      this.flagUrl = Constants.categoryIcon + alpha2.toLowerCase() + ".png";
    else if (flag != null)
      this.flagUrl = Constants.categoryIcon + flag.toLowerCase() + ".png";
  }

  @override
  int compareTo(other) {
    if (other == null) return -1;
    if (this.priority > other.priority) return -1;
    if (this.priority < other.priority) return 1;
    return this.name.compareTo(other.name);
  }

  Category.fromJson(Map<String, dynamic> json) {
    this.name = json["name"];
    this.slug = json["slug"];
    this.priority = json["priority"];
    this.id = json["id"];
    this.flag = json["flag"];
    this.alpha2 = json["alpha2"];
    if (alpha2 == null)
      this.flagUrl = Constants.categoryIcon + flag + ".png";
    else
      this.flagUrl = Constants.categoryIcon + alpha2 + ".png";
  }
}

// class CategoryResponse {
//   int total = 0;
//   late List<Category> categories;

//   CategoryResponse.fromJson(Map<String, dynamic> json) {
//     if (json["categories"] != null) {
//       this.categories = [];
//       json["categories"].forEach((i) {
//         categories.add(new Category.fromJson(i));
//         total++;
//       });
//       var logger = Logger();
//       logger.i(total.toString() + " categories received");
//     }
//   }
// }
