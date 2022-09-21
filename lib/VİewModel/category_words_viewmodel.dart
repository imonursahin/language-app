import 'package:flutter_tts/flutter_tts.dart';
import 'package:wordstart/Model/words_model.dart';
import 'package:wordstart/Services/category_words_service.dart';

Future<List<WordsModel>> showWords(int categoryId) async {
  var wordsList = await CategoryWordsService().getCategoryWords(categoryId);
  return wordsList;
}

class Speech {
  final FlutterTts tts = FlutterTts();

  speak(String text) async {
    await tts.setLanguage("tr-TR");
    await tts.setPitch(1);
    await tts.setSpeechRate(0.8);
    await tts.speak(text);
  }
}

final FlutterTts tts = FlutterTts();

Future _speak(String text) async {
  await tts.setLanguage("en-Us");
  await tts.setPitch(1);
  await tts.setSpeechRate(0.3);
  await tts.speak(text);
}
