import 'package:wordstart/Model/category_model.dart';
import 'db_helper.dart';

class CategoryService {
// get all category
  Future<List<CategoryModel>> getAllCategory() async {
    var db = await DbHelper.dbInstance();

    List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM categories");

    return List.generate(maps.length, (i) {
      var row = maps[i];
      return CategoryModel(row["categoryId"], row["categoryName"]);
    });
  }

  // finds the number of category
  Future<int> getNumberOfCategory(int categoryId) async {
    var db = await DbHelper.dbInstance();

    List<Map<String, dynamic>> maps = await db
        .rawQuery("SELECT COUNT(*) FROM words where categoryId = $categoryId");

    return maps[0]["COUNT(*)"];
  }
}
