import 'dart:io';

import 'package:get/get.dart';
import 'package:shop_app/comtrollers/profile_controller.dart';
import 'package:shop_app/consts/consts.dart';
import 'package:shop_app/widgets_common/custom_textfield.dart';
import 'package:shop_app/widgets_common/out_button.dart';

import '../../../widgets_common/bg_widget.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                children: [
                  data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                      ? Image.asset(imgProfile, width: 80, fit: BoxFit.cover)
                          .box
                          .clip(Clip.antiAlias)
                          .roundedFull
                          .make()
                      : data['imageUrl'] != '' &&
                              controller.profileImgPath.isEmpty
                          ? Image.network(data['imageUrl'],
                                  width: 80, fit: BoxFit.cover)
                              .box
                              .clip(Clip.antiAlias)
                              .roundedFull
                              .make()
                          : Image.file(
                              File(controller.profileImgPath.value),
                              width: 80,
                              fit: BoxFit.cover,
                            ).box.clip(Clip.antiAlias).roundedFull.make(),
                  5.heightBox,
                  ourButton(
                      color: redColor,
                      onPress: () {
                        controller.changeImage(context);
                      },
                      textColor: whiteColor,
                      title: "Changed"),
                  5.heightBox,
                  customTextField(
                      hint: nameHint,
                      title: name,
                      controller: controller.nameController,
                      isPass: false),
                  10.heightBox,
                  customTextField(
                      hint: passwordHint,
                      title: oldpass,
                      controller: controller.oldpassController,
                      isPass: true),
                  10.heightBox,
                  customTextField(
                      hint: passwordHint,
                      title: newpass,
                      controller: controller.newpassController,
                      isPass: true),
                  10.heightBox,
                   SizedBox(
                          width: context.screenWidth - 60,
                          child: ourButton(
                              color: redColor,
                              onPress: () async {
                              
                                // if image is not selected
                                if (controller.profileImgPath.isNotEmpty) {
                                  await controller.uploadProfileImage();
                                } else {
                                  controller.profileImageLink =
                                      data['imageUrl'];
                                }
                                // neu password khong  thay doi
                                if (data['password'] ==
                                    controller.oldpassController.text) {
                                  await controller.changAuthPassword(
                                      email: data['email'],
                                      password:
                                          controller.oldpassController.text,
                                      newpassword:
                                          controller.newpassController.text);
                                  await controller.updateProfile(
                                    imgUrl: controller.profileImageLink,
                                    name: controller.nameController.text,
                                    password: controller.newpassController.text,
                                  );
                                  // ignore: use_build_context_synchronously
                                  VxToast.show(context, msg: "Updated");
                                } else {
                                  // ignore: use_build_context_synchronously
                                  VxToast.show(context,
                                      msg: "Wrong old password");
                                 
                                }
                              },
                              textColor: whiteColor,
                              title: "Save"),
                        ),
                ],
              )
                  .box
                  .white
                  .padding(const EdgeInsets.all(16))
                  .margin(const EdgeInsets.only(top: 5))
                  .rounded
                  .make(),
            )));
  }
}
