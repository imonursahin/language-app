import 'category_model.dart';

class WordsModel {
  int? wordsId;
  String? turkish;
  String? english;
  CategoryModel? category;

  WordsModel(this.wordsId, this.turkish, this.english, this.category);
}
