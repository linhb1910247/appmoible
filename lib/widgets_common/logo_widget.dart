import '../consts/consts.dart';

Widget logoWidget() {
  // sử dungk velcoity X;
  return Image.asset(icAppLogo)
      .box
      .size(77, 77)
      .padding(const EdgeInsets.all(2))
      .rounded
      .make();
}
