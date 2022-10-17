import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wordstart/Model/category_model.dart';
import 'package:wordstart/Model/words_model.dart';
import '../VİewModel/category_words_viewmodel.dart';

class CategoryWordsPage extends StatefulWidget {
  final CategoryModel category;

  const CategoryWordsPage({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryWordsPage> createState() => _CategoryWordsPageState();
}

class _CategoryWordsPageState extends State<CategoryWordsPage> {
  // Favorite
  List<WordsModel> favoritedWordsList = [];
  bool isFavorite = false;

  // Speech
  Speech speechService = Speech();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(widget.category.categoryName ?? ""),
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
                tabs: const [
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
          body: _buildBody(),
        ),
      ),
    );
  }

  TabBarView _buildBody() {
    return TabBarView(
      children: [
        _buildWordsList(),
        // FAVORİTE PAGE
        favoritedWordsList.isEmpty
            ? Center(
                child: Text(
                  'Henüz öğrendiğiniz kelime yok. 😢',
                  style: TextStyle(color: Colors.black),
                ),
              )
            : _buildFavoriteWordList()
      ],
    );
  }

  ListView _buildFavoriteWordList() {
    return ListView.builder(
        itemCount: favoritedWordsList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          var words = favoritedWordsList[index];
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      height: 12.h,
                      color: Colors.blueGrey[50],
                      child: Row(children: <Widget>[
                        Container(
                          color: Colors.black,
                          width: 20.w,
                          height: 40.h,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.volume_up, color: Colors.white)),
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "🇹🇷 ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp),
                                  ),
                                  Text(
                                    words.turkish ?? "",
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Text(
                                    "🇬🇧 ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp),
                                  ),
                                  Text(
                                    words.english ?? "",
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                            icon: isFavorite == true
                                ? Icon(
                                    Icons.favorite,
                                    size: 18,
                                  )
                                : Icon(
                                    Icons.favorite_border_outlined,
                                    size: 18,
                                  ),
                            color: Colors.red,
                            onPressed: () async {
                              setState(() {
                                favoritedWordsList
                                    .remove(favoritedWordsList[index]);
                              });
                            })
                      ]))));
        });
  }

  FutureBuilder<List<WordsModel>> _buildWordsList() {
    return FutureBuilder<List<WordsModel>>(
        future: showWords(widget.category.categoryId!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var wordsList = snapshot.data;
            return ListView.builder(
                itemCount: wordsList!.length,
                itemBuilder: (context, index) {
                  var words = wordsList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 12.h,
                        color: Colors.blueGrey[50],
                        child: Row(
                          children: <Widget>[
                            Container(
                              color: Colors.black,
                              width: 20.w,
                              height: 40.h,
                              child: IconButton(
                                  onPressed: () {
                                    speechService.speak(words.english ?? "");
                                  },
                                  icon: Icon(Icons.volume_up,
                                      color: Colors.white)),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "🇹🇷 ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp),
                                      ),
                                      Text(
                                        words.turkish ?? "",
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Text(
                                        "🇬🇧 ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp),
                                      ),
                                      Text(
                                        words.english ?? "",
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                icon: isFavorite == true
                                    ? Icon(
                                        Icons.favorite,
                                        size: 18,
                                      )
                                    : Icon(
                                        Icons.favorite_border_outlined,
                                        size: 18,
                                      ),
                                color: Colors.red,
                                onPressed: () {
                                  setState(() {
                                    if (isFavorite == false) {
                                      isFavorite = true;
                                      favoritedWordsList.add(wordsList[index]);

                                      wordsList.remove(wordsList[index]);
                                    }
                                  });
                                })
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
