import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AllWordsPage extends StatefulWidget {
  const AllWordsPage({super.key});

  @override
  State<AllWordsPage> createState() => _AllWordsPageState();
}

class _AllWordsPageState extends State<AllWordsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 15,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 15.h,
                  color: Colors.blueGrey[50],
                  child: Row(
                    children: <Widget>[
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
                                  "Araba",
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
                                  "Car",
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Text(
                                  "🗣️ ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp),
                                ),
                                Text(
                                  "Kar",
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          icon: "isFavorite" == true
                              ? Icon(
                                  Icons.favorite,
                                  size: 18,
                                )
                              : Icon(
                                  Icons.favorite_border_outlined,
                                  size: 18,
                                ),
                          color: Colors.red,
                          onPressed: () async {})
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
