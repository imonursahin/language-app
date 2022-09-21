import 'package:wordstart/Model/words_model.dart';
import 'package:wordstart/Services/db_helper.dart';

class SearchService {
  Future<List<WordsModel>> search(String searchWord) async {
    var db = await DbHelper.dbInstance();

    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM kelimeler WHERE ingilizce like '%$searchWord%'");

    return List.generate(maps.length, (i) {
      var row = maps[i];
      return WordsModel(
          row[""], row["turkish"], row["english"], row[""], row[""]);
    });
  }
}
