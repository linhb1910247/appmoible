import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shop_app/comtrollers/auth_controllers.dart';
import 'package:shop_app/consts/list.dart';
import 'package:shop_app/views/profile_screen/components/edit_profile_screen.dart';

import '../../comtrollers/profile_controller.dart';
import '../../consts/consts.dart';
import '../../services/firestore_service.dart';
import '../../widgets_common/bg_widget.dart';
import '../auth_screen/login_screen.dart';
import '../cart_screen/components/details_cart.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
                stream: FirestoreServices.getUser(currentUser!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ));
                  } else {
                    var data = snapshot.data!.docs[0];
                    return SafeArea(
                        child: Column(
                      children: [
                        // edit profile button
                        const Align(
                                alignment: Alignment.topRight,
                                child: Icon(Icons.edit, color: darkFontGrey))
                            .onTap(() {
                          controller.nameController.text = data['name'];

                          Get.to(() => EditProfileScreen(data: data));
                        }),
                        //user details section
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              data['imageUrl'] == ''
                                  ? Image.asset(imgProfile,
                                          width: 80, fit: BoxFit.cover)
                                      .box
                                      .clip(Clip.antiAlias)
                                      .roundedFull
                                      .make()
                                  : Image.network(data['imageUrl'],
                                          width: 80, fit: BoxFit.cover)
                                      .box
                                      .clip(Clip.antiAlias)
                                      .roundedFull
                                      .make(),
                              10.widthBox,
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "${data['name']}"
                                          ""
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  5.heightBox,
                                  "${data['email']}"
                                      .text
                                      .color(darkFontGrey)
                                      .make(),
                                ],
                              )),
                              OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                    color: darkFontGrey,
                                  )),
                                  onPressed: () async {
                                    await Get.put(AuthController()
                                        .signoutMethod(context));
                                    Get.offAll(() => const LoginScreen());
                                  },
                                  child: logout.text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make())
                            ],
                          ),
                        ),
                        20.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detailsCard(
                                count: data['cart_count'],
                                title: "in your card",
                                width: context.screenWidth / 3.4),
                            detailsCard(
                                count: data['wishlist_count'],
                                title: "in your wishlist",
                                width: context.screenWidth / 3.4),
                            detailsCard(
                                count: data['order_count'],
                                title: "yours orders",
                                width: context.screenWidth / 3.4),
                          ],
                        ),
                        40.heightBox,
                        //button section****************************************************************
                        ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    leading: Image.asset(
                                        profileButtonIcons[index],
                                        width: 22),
                                    title: profileButtonList[index]
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    color: darkFontGrey,
                                  );
                                },
                                itemCount: profileButtonList.length)
                            .box
                            .white
                            .rounded
                            .padding(const EdgeInsets.symmetric(horizontal: 16))
                            .shadowSm
                            .make()
                            .box
                            .color(blue1)
                            .make(),
                      ],
                    ));
                  }
                })));
  }
}
