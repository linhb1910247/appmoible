import 'package:get/get.dart';
import 'package:shop_app/consts/consts.dart';
import 'package:shop_app/views/auth_screen/signup_screen.dart';
import 'package:shop_app/widgets_common/bg_widget.dart';
import 'package:shop_app/widgets_common/logo_widget.dart';

import '../../comtrollers/auth_controllers.dart';
import '../../consts/list.dart';
import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/out_button.dart';
import '../home_screen/home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
        children: [
          (context.screenHeight * 0.1).heightBox,
          logoWidget(),
          10.heightBox,
          "Login to $appname".text.fontFamily(bold).black.size(30).make(),
          20.heightBox,
          Obx(
            () => Column(
              children: [
                customTextField(
                    hint: emailHint,
                    title: email,
                    controller: controller.emailController,
                    isPass: false),
                customTextField(
                    hint: passwordHint,
                    title: password,
                    controller: controller.passwordController,
                    isPass: true),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: forgetPass.text.make())),
                5.heightBox,
                // ourButton().box.width(context.screenWidth - 50).make(),
                controller.isloading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor))
                    : ourButton(
                        color: blue1,
                        title: login,
                        textColor: whiteColor,
                        onPress: () async {
                          controller.isloading(true);
                          await controller
                              .loginMethod(context: context)
                              .then((value) {
                            if (value != null) {
                              VxToast.show(context, msg: loggedin);
                              Get.offAll(() => const Home());
                            } else {
                              controller.isloading(false);
                            }
                          });
                        }).box.width(context.screenWidth - 50).make(),
                createNewAccount.text.color(fontGrey).make(),
                5.heightBox,
                ourButton(
                    color: golden,
                    title: singup,
                    textColor: whiteColor,
                    onPress: () {
                      Get.to(() => const SingupScreen());
                    }).box.width(context.screenWidth - 50).make(),
                10.heightBox,
                loginWith.text.color(fontGrey).make(),
                5.heightBox,
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: lightGrey,
                            radius: 25,
                            child: Image.asset(
                              socialIconList[index],
                              width: 30,
                            ),
                          )),
                    )),
              ],
            )
                .box
                .purple50
                .rounded
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .shadowSm
                .make(),
          ),
          5.heightBox,
        ],
      )),
    ));
  }
}
