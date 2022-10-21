import 'package:wordstart/Model/category_model.dart';
import 'package:wordstart/Model/words_model.dart';
import 'db_helper.dart';

class CategoryWordsService {
  Future<List<WordsModel>> getCategoryWords(int categoryId) async {
    var db = await DbHelper.dbInstance();

    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM words WHERE categoryId = $categoryId ORDER BY english ASC");

    return List.generate(maps.length, (i) {
      var row = maps[i];
      int categoryID = int.parse(row["categoryId"].toString());

      var word = WordsModel(row["wordsId"], row["turkish"], row["english"],
          CategoryModel(categoryID, row["categoryName"]));

      return word;
    });
  }
}
