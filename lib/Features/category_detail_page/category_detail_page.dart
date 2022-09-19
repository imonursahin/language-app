import 'package:flutter/material.dart';
import 'package:wordstart/Model/category_model.dart';

import 'all_words_page.dart';

class CategoryDetailPage extends StatefulWidget {
  const CategoryDetailPage({super.key, required CategoryModel category});

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text("YDS Kelimeleri"),
              centerTitle: true,
              elevation: 1,
              bottom: TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.white,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white),
                  tabs: [
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("📋 Tüm Kelimeler"),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("💪 Öğrendiklerim"),
                      ),
                    ),
                  ]),
            ),
            body: TabBarView(children: [
              AllWordsPage(),
              AllWordsPage(),
            ]),
          ),
        ));
  }
}
