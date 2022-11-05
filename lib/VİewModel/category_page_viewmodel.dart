import 'package:flutter/material.dart';
import 'package:wordstart/Model/category_model.dart';
import 'package:wordstart/Model/words_model.dart';
import 'package:wordstart/Services/category_service.dart';
import 'package:wordstart/Services/search_service.dart';

import 'category_words_viewmodel.dart';

class CategoryPageViewModel {
  bool isSearching = false;
  late String searchString;

  TextEditingController searchController = TextEditingController();

  // Speech
  Speech speechService = Speech();

  Future<List<CategoryModel>> showCategory() async {
    var categoryList = await CategoryService().getAllCategory();
    return categoryList;
  }

  Future<List<WordsModel>> search(String searchWord) async {
    var result = await SearchService().search(searchWord);
    return result;
  }

  Future<int> getNumberOfCategory(int categoryId) async {
    var numberOfCategory =
        await CategoryService().getNumberOfCategory(categoryId);
    return numberOfCategory;
  }
}
