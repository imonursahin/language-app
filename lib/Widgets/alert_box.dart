import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

Future<dynamic> buildAlertInfo(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.85),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Text(
            "İngilizce öğrenmek artık çok kolay!",
            style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500),
          ),
          content: Text(
            "\n wordStart içerisinde binlerce kelime bulunduran ücretsiz bir ingilizce kelime öğrenme uygulamasıdır.\n\n\n❤️ Favorilere ekleme.\n\n📶 İnternetsiz kullanım.\n\n📣 Sürekli güncellenen kelime haznesi.\n\n\n 📢 Sesleri dinlemek için Speech Services by Google uygulamasını indirmeniz gerekmektedir!\n\n\n 📩  wordstart.app@gmail.com ",
            style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w300),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Row(
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.orange,
                      ),
                      Text(
                        "Arkadaşına Öner",
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Share.share(
                        "Selam 👋 Mükemmel bir uygulama buldum! wordStart ile ingilizce öğrenmek artık çok kolay!  İçerisinde binlerce kelime bulunduran ücretsiz ingilizce kelime öğrenme uygulaması.");
                  },
                ),
                TextButton(
                  child: Row(
                    children: [
                      Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                      Text(
                        "Kapat",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
