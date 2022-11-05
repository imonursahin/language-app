import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wordstart/Model/category_model.dart';
import 'package:wordstart/Model/words_model.dart';
import 'package:wordstart/Services/mail_service.dart';
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
  List<bool> isFavorite = [false];

  @override
  void initState() {
    super.initState();
    CategoryWordsViewModel().mailService = MailService();
  }

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
                      child: Text("📋 Kelimeler"),
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
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Henüz öğrendiğiniz kelime yok. 😢',
                    style: TextStyle(color: Colors.black),
                  ),
                  Divider(),
                  Text(
                    'Öğrendiğiniz tüm kelimeleri favorilere ekleyebilirsiniz.',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w300),
                  ),
                ],
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
              padding: const EdgeInsets.all(6.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      height: 14.h,
                      color: Colors.blueGrey[50],
                      child: Row(children: <Widget>[
                        Container(
                          color: Colors.black,
                          width: 20.w,
                          height: 40.h,
                          child: IconButton(
                              onPressed: () {
                                CategoryWordsViewModel()
                                    .speechService
                                    .speak(words.english!);
                              },
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
                                    "🇬🇧 ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp),
                                  ),
                                  Expanded(
                                    child: Text(
                                      words.english ?? "",
                                      maxLines: 2,
                                      style: TextStyle(fontSize: 10.sp),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Text(
                                    "🇹🇷 ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp),
                                  ),
                                  Expanded(
                                    child: Text(
                                      words.turkish ?? "",
                                      maxLines: 2,
                                      style: TextStyle(fontSize: 10.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                            icon: Icon(isFavorite.elementAt(index)
                                ? Icons.favorite
                                : Icons.favorite_border),
                            color:
                                isFavorite.elementAt(index) ? Colors.red : null,
                            onPressed: () {
                              setState(() {
                                favoritedWordsList.removeAt(index);
                              });
                            })
                      ]))));
        });
  }

  FutureBuilder<List<WordsModel>> _buildWordsList() {
    return FutureBuilder<List<WordsModel>>(
        future: CategoryWordsViewModel().showWords(widget.category.categoryId!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var wordsList = snapshot.data;
            return ListView.builder(
                itemCount: wordsList!.length,
                itemBuilder: (context, index) {
                  var words = wordsList[index];
                  isFavorite.add(false);

                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 14.h,
                        color: Colors.blueGrey[50],
                        child: Row(
                          children: <Widget>[
                            Container(
                              color: Colors.black,
                              width: 20.w,
                              height: 40.h,
                              child: IconButton(
                                  onPressed: () {
                                    CategoryWordsViewModel()
                                        .speechService
                                        .speak(words.english!);
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
                                        "🇬🇧 ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp),
                                      ),
                                      Expanded(
                                        child: Text(
                                          words.english ?? "",
                                          maxLines: 2,
                                          style: TextStyle(fontSize: 10.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Text(
                                        "🇹🇷 ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp),
                                      ),
                                      Expanded(
                                        child: Text(
                                          words.turkish ?? "",
                                          maxLines: 2,
                                          style: TextStyle(fontSize: 10.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Tooltip(
                                  message: "Öğrendim",
                                  child: IconButton(
                                      icon: Icon(isFavorite.elementAt(index)
                                          ? Icons.favorite
                                          : Icons.favorite_border),
                                      color: isFavorite.elementAt(index)
                                          ? Colors.red
                                          : null,
                                      onPressed: () {
                                        setState(() {
                                          isFavorite[index] =
                                              !isFavorite.elementAt(index);
                                          if (isFavorite.elementAt(index)) {
                                            favoritedWordsList.add(words);
                                          } else {
                                            favoritedWordsList.remove(words);
                                          }
                                        });
                                      }),
                                ),
                                Tooltip(
                                  message: "Hata Bildir",
                                  child: IconButton(
                                      onPressed: () {
                                        _buildReportAlertBox(context, words);
                                      },
                                      icon: Icon(
                                        Icons.report_problem,
                                        color: Colors.black,
                                        size: 18,
                                      )),
                                ),
                              ],
                            )
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

  Future<dynamic> _buildReportAlertBox(BuildContext context, WordsModel words) {
    return showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: AlertDialog(
                title: Text("Hata Bildir !"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${words.english} \n${words.turkish} \n\n"
                        "Bu kelimeyi hatalı olarak bildirmek istediğinize emin misiniz?"),
                    SizedBox(height: 2.h),
                    TextField(
                      controller: CategoryWordsViewModel().reportController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: "Hata Açıklaması (isteğe bağlı)",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.black,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        CategoryWordsViewModel().reportController.clear();
                      },
                      child: Text(
                        "Hayır",
                        style: TextStyle(color: Colors.black),
                      )),
                  TextButton(
                      onPressed: () {
                        CategoryWordsViewModel().reportTurkish =
                            words.turkish.toString();
                        CategoryWordsViewModel().reportEnglish =
                            words.english.toString();
                        CategoryWordsViewModel().reportCategory =
                            widget.category.categoryName.toString();
                        String reportMessage = CategoryWordsViewModel()
                            .reportController
                            .text
                            .toString();

                        CategoryWordsViewModel().mailService!.sendMail(
                            CategoryWordsViewModel().reportMail,
                            CategoryWordsViewModel().reportTurkish,
                            CategoryWordsViewModel().reportEnglish,
                            CategoryWordsViewModel().reportCategory,
                            reportMessage);

                        CategoryWordsViewModel().reportController.clear();

                        Navigator.pop(context);

                        // snackBar
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Hata bildirildi. Teşekkürler."),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.black,
                        ));
                      },
                      child: Text(
                        "Evet",
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              ));
        });
  }
}
