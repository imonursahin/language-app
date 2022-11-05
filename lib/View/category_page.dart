import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wordstart/Model/category_model.dart';
import '../VİewModel/category_page_viewmodel.dart';
import 'category_words_page.dart';
import 'dart:math' as math;
import 'package:wordstart/Model/words_model.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.black),
            ),
            title: Text(
              "Kategori Seç",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: _buildBody(),
        ),
      ),
    );
  }

  SingleChildScrollView _buildBody() {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.all(12.sp),
      child: Center(
          child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Bugün ne \nöğrenmek istiyorsun? 🤔",
              style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 2.h),
          TextField(
            controller: CategoryPageViewModel().searchController,
            cursorColor: Colors.blueGrey[50],
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black45,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    CategoryPageViewModel().searchController.clear();
                    CategoryPageViewModel().isSearching = false;
                  });
                },
              ),
              hintText: "İngilizce veya Türkçe Kelime Ara",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none),
              fillColor: Color.fromARGB(255, 235, 235, 240),
              filled: true,
            ),
            onChanged: (searchResult) {
              setState(() {
                CategoryPageViewModel().searchString = searchResult;
                if (CategoryPageViewModel().searchString.isEmpty) {
                  CategoryPageViewModel().isSearching = false;
                } else {
                  CategoryPageViewModel().isSearching = true;
                  CategoryPageViewModel()
                      .search(CategoryPageViewModel().searchString);
                }
              });
            },
          ),
          SizedBox(height: 2.h),
          CategoryPageViewModel().isSearching
              ? Center(
                  child: Column(
                    children: [
                      Text(
                        "Arama Sonuçları",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Divider(),
                      Text(
                        "Kategorileri görmek için arama kutusunu temizleyin.",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w300),
                      ),
                      SizedBox(height: 2.h),
                      // SEARCH LİST
                      _buildSearchList()
                    ],
                  ),
                )
              // CATEGORY LİST
              : _buildCategoryList()
        ],
      )),
    ));
  }

  FutureBuilder<List<CategoryModel>> _buildCategoryList() {
    return FutureBuilder<List<CategoryModel>>(
        future: CategoryPageViewModel().showCategory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var categoryList = snapshot.data;
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                itemCount: categoryList!.length,
                itemBuilder: (context, index) {
                  var category = categoryList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CategoryWordsPage(category: category)),
                          );
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                                height: 10.h,
                                color: Colors.blueGrey[50],
                                child: Row(children: <Widget>[
                                  Container(
                                    color: Color((math.Random().nextDouble() *
                                                0xFFFFFF)
                                            .toInt())
                                        .withOpacity(1.0),
                                    width: 20.w,
                                    height: 40.h,
                                    child: Center(
                                      child: Text(
                                        '${index + 1}',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 2.w),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          category.categoryName.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.sp),
                                        ),
                                        FutureBuilder(
                                            future: CategoryPageViewModel()
                                                .getNumberOfCategory(index + 1),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                var numberOfCategory =
                                                    snapshot.data;
                                                return Text(
                                                  "$numberOfCategory Kelime",
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                );
                                              } else {
                                                return Text(
                                                    "Henüz kelime eklenmedi.");
                                              }
                                            }),
                                      ],
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios_sharp,
                                      color: Colors.black)
                                ])))),
                  );
                });
          }
          return Center(child: CircularProgressIndicator(color: Colors.black));
        });
  }

  FutureBuilder<List<WordsModel>> _buildSearchList() {
    return FutureBuilder(
      future:
          CategoryPageViewModel().search(CategoryPageViewModel().searchString),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
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
                                setState(() {
                                  CategoryPageViewModel()
                                      .speechService
                                      .speak(snapshot.data[index].english!);
                                });
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
                                      snapshot.data[index].english ?? "",
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
                                      snapshot.data[index].turkish ?? "",
                                      maxLines: 2,
                                      style: TextStyle(fontSize: 10.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        }
      },
    );
  }
}
