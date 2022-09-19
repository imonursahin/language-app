import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wordstart/Model/category_model.dart';
import 'package:wordstart/Services/db_dao.dart';
import 'category_detail_page/category_detail_page.dart';
import 'dart:math' as math;

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isSearch = false;
  String searchWord = "";
  TextEditingController searchController = TextEditingController();

  Future<List<CategoryModel>> showCategory() async {
    var categoryList = await DbDao().getAllCategory();
    return categoryList;
  }

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
          body: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.all(12.sp),
            child: Center(
                child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Bugün ne \nöğrenmek istiyorsun 🤔",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 2.h),
                TextField(
                  controller: searchController,
                  cursorColor: Colors.blueGrey[50],
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black45,
                    ),
                    hintText: "İngilizce veya Türkçe Kelime Ara",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none),
                    fillColor: Color.fromARGB(255, 235, 235, 240),
                    filled: true,
                  ),
                ),
                SizedBox(height: 2.h),
                FutureBuilder<List<CategoryModel>>(
                    future: showCategory(),
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
                                                CategoryDetailPage(
                                                    category: category)),
                                      );
                                    },
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                            height: 10.h,
                                            color: Colors.blueGrey[50],
                                            child: Row(children: <Widget>[
                                              Container(
                                                color: Color((math.Random()
                                                                .nextDouble() *
                                                            0xFFFFFF)
                                                        .toInt())
                                                    .withOpacity(1.0),
                                                width: 20.w,
                                                height: 40.h,
                                                child: Center(
                                                  child: Text(
                                                    '#${index + 1}',
                                                    style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                      category.categoryName,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14.sp),
                                                    ),
                                                    Text('2000 kelime',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12.sp))
                                                  ],
                                                ),
                                              ),
                                              Icon(
                                                  Icons.arrow_forward_ios_sharp,
                                                  color: Colors.black)
                                            ])))),
                              );
                            });
                      }
                      return Center(child: CircularProgressIndicator());
                    })
              ],
            )),
          )),
        ),
      ),
    );
  }
}
