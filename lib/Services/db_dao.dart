import 'package:wordstart/Model/category_model.dart';
import 'db_helper.dart';

class DbDao {
// get all category
  Future<List<CategoryModel>> getAllCategory() async {
    var db = await DbHelper.dbInstance();

    List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM categories");

    return List.generate(maps.length, (i) {
      return CategoryModel(maps[i]["categoryId"], maps[i]["categoryName"]);
    });
  }

  // get category words by category id
  Future<List<CategoryModel>> getCategoryWords(int categoryId) async {
    var db = await DbHelper.dbInstance();

    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM words WHERE categoryId = ? ORDER BY categoryName ASC",
        [categoryId]);

    return List.generate(maps.length, (i) {
      return CategoryModel(maps[i]["categoryId"], maps[i]["categoryName"]);
    });
  }
}
