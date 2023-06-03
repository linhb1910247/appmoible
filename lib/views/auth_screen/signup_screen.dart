import 'package:get/get.dart';

import '../../comtrollers/auth_controllers.dart';
import '../../consts/consts.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/logo_widget.dart';
import '../../widgets_common/out_button.dart';
import '../home_screen/home.dart';

class SingupScreen extends StatefulWidget {
  const SingupScreen({Key? key}) : super(key: key);

  @override
  State<SingupScreen> createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());
  //text cotroller

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
        children: [
          (context.screenHeight * 0.1).heightBox,
          logoWidget(),
          10.heightBox,
          "Join in $appname".text.fontFamily(bold).black.size(30).make(),
          20.heightBox,
          Obx(
            () => Column(
              children: [
                customTextField(
                    hint: nameHint,
                    title: name,
                    controller: nameController,
                    isPass: false),
                customTextField(
                    hint: emailHint,
                    title: email,
                    controller: emailController,
                    isPass: false),
                customTextField(
                    hint: passwordHint,
                    title: password,
                    controller: passwordController,
                    isPass: true),
                customTextField(
                    hint: passwordHint,
                    title: retypePassword,
                    controller: passwordRetypeController,
                    isPass: true),
                // ourButton().box.width(context.screenWidth - 50).make(),
                5.heightBox,
                Row(
                  children: [
                    Checkbox(
                      checkColor: redColor,
                      value: isCheck,
                      onChanged: (newvalue) {
                        setState(() {
                          isCheck = newvalue;
                        });
                        isCheck = newvalue;
                      },
                    ),
                    10.heightBox,
                    Expanded(
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: "I agree to the",
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: fontGrey,
                                )),
                            TextSpan(
                                text: termAndcond,
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: redColor,
                                )),
                            TextSpan(
                                text: " & ",
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: fontGrey,
                                )),
                            TextSpan(
                                text: privacyPolicy,
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: redColor,
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                controller.isloading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor))
                    : ourButton(
                        color: isCheck == true ? blue1 : fontGrey,
                        title: singup,
                        textColor: whiteColor,
                        onPress: () async {
                          if (isCheck != false) {
                            controller.isloading(true);
                            try {
                              await controller
                                  .signupMethod(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      context: context)
                                  .then((value) {
                                return controller.storeUserData(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                );
                              }).then((value) {
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(() => const Home());
                              });
                            } catch (e) {
                              auth.signOut();
                              VxToast.show(context, msg: e.toString());
                              controller.isloading(false);
                            }
                          }
                        }).box.width(context.screenWidth - 50).make(),
                // dp hanh dong quay ve cua velocity X
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: alreadyHaveAccount,
                        style: TextStyle(fontFamily: bold, color: fontGrey),
                      ),
                      TextSpan(
                        text: login,
                        style: TextStyle(fontFamily: bold, color: redColor),
                      ),
                    ],
                  ),
                ).onTap(() {
                  Get.back();
                })
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
        ],
      )),
    ));
  }
}
