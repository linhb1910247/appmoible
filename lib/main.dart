import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:shop_app/views/splash_screen.dart';
import 'consts/consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //su dung getX vi vay phai thay doi marterial thanh getmateriallapp
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
            // **thiet lap mau icon appbar ****
            iconTheme: IconThemeData(color: darkFontGrey),
            backgroundColor: Color.fromARGB(237, 244, 241, 241)),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}
