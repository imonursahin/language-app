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
}
