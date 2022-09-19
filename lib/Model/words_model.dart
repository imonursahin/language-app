import 'category_model.dart';

class WordsModel {
  int? wordsId;
  String? turkish;
  String? english;
  String? pronunciation;
  CategoryModel? category;

  WordsModel(this.wordsId, this.turkish, this.english, this.pronunciation,
      this.category);
}
