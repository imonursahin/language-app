import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class MailService {
  sendMail(String email, String reportTurkish, String reportEnglish,
      String reportCategory, String reportMessage) async {
    String username = 'wordstart@onursahin.net';
    String password = '+zmrI-HzFF6O';
    String domainSmtp = 'mail.onursahin.net';

    //also use for gmail smtp
    // ignore: deprecated_member_usegmail
    // final smtpServer = yandex(username, password);

    //user for your own domain
    final smtpServer = SmtpServer(domainSmtp,
        username: username, password: password, port: 587);

    final message = Message()
      ..from = Address(username, 'wordStart')
      ..recipients.add(email)
      //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'wordStart Report'
      ..text = ' Aşağıdaki kelimelerde hata bulunmaktadır. : \n\n'
          'Kategori : $reportCategory \n\n'
          'Türkçe : $reportTurkish \n\n'
          'İngilizce : $reportEnglish \n\n'
          'Mesaj : $reportMessage \n\n'
          'İyi Çalışmalar Dileriz.';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
