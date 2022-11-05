import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:wordstart/Model/words_model.dart';
import 'package:wordstart/Services/category_words_service.dart';

import '../Services/mail_service.dart';

class CategoryWordsViewModel {
  Future<List<WordsModel>> showWords(int categoryId) async {
    var wordsList = await CategoryWordsService().getCategoryWords(categoryId);
    return wordsList;
  }

  // Mail
  MailService? mailService;

  String reportMail = 'wordstart.app@gmail.com';
  String reportTurkish = '';
  String reportEnglish = '';
  String reportCategory = '';
  TextEditingController reportController = TextEditingController();

  // Speech
  Speech speechService = Speech();
}

class Speech {
  final FlutterTts tts = FlutterTts();

  speak(String text) async {
    await tts.setLanguage("en-US");
    await tts.setPitch(1);
    await tts.setSpeechRate(0.3);
    await tts.speak(text);
  }
}
