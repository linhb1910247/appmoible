import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shop_app/comtrollers/product_controller.dart';

import '../../consts/consts.dart';
import '../../services/firestore_service.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/loading_indicator.dart';
import 'item_details.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: title!.text.black.fontFamily(bold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "Mo products found!".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            return Container(
                padding: const EdgeInsets.all(12),
                child: Column(children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(
                            controller.subcat.length,
                            (index) => "${controller.subcat[index]}"
                                .text
                                .size(12)
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .makeCentered()
                                .box
                                .white
                                .rounded
                                .size(120, 60)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .make())),
                  ),
                  20.heightBox,
                  //***items container* */
                  Expanded(
                      child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 250,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            data[index]['p-imgs'][1],
                            width: 110,
                            fit: BoxFit.fill,
                          ),
                          10.heightBox,
                          "${data[index]['p_name']}"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          10.heightBox,
                          "${data[index]['p_price']}"
                              .numCurrency
                              .text
                              .color(redColor)
                              .fontFamily(bold)
                              .size(16)
                              .make()
                        ],
                      )
                          .box
                          .white
                          .margin(
                            const EdgeInsets.symmetric(horizontal: 4),
                          )
                          .roundedSM
                          .outerShadowSm
                          .padding(const EdgeInsets.all(8))
                          .make()
                          .onTap(() {
                        Get.to(() => ItemDetails(
                            title: "${data[index]['p_name']}",
                            data: data[index]));
                      });
                    },
                  ))
                ]));
          }
        },
      ),
    ));
  }
}
