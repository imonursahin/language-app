import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Widgets/alert_box.dart';
import 'category_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: RichText(
              text: TextSpan(
                  text: "🥧 wordS",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp),
                  children: <TextSpan>[
                TextSpan(
                  text: "tart",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 15.sp),
                )
              ])),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                buildAlertInfo(context);
              },
              icon: Icon(
                Icons.info_outline,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(12.sp),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "herkes için",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w200,
                          fontSize: 18.sp),
                    ),
                    Text("İngilizce Dil Öğrenme",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp)),
                    SizedBox(height: 1.h),
                    SizedBox(
                        width: 300.w,
                        child: Image.asset('assets/images/homepic3.png')),
                    SizedBox(height: 4.h),
                    Text("Herkes için ingilizce öğrenmenin \nen kolay yolu ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w200,
                            fontSize: 16.sp)),
                    SizedBox(height: 4.h),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryPage()),
                        );
                      },
                      child: Container(
                        height: 8.h,
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                          child: Text(
                            "Öğrenmeye Başla   👉",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
