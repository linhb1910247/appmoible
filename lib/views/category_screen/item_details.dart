import 'package:get/get.dart';
import 'package:shop_app/comtrollers/product_controller.dart';

import '../../consts/consts.dart';
import '../../widgets_common/out_button.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({Key? key, required this.title, this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(Color.fromARGB(255, 209, 207, 207).value);
    var controller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
          backgroundColor: lightGrey,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  controller.resetValues();
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back)),
            title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
            ],
          ),
          body: Column(children: [
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //***wipper section****
                        VxSwiper.builder(
                            autoPlay: true,
                            height: 350,
                            itemCount: data['p-imgs'].length,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1.0,
                            itemBuilder: (context, index) {
                              return Image.network(
                                data['p-imgs'][index],
                                width: double.infinity,
                                fit: BoxFit.cover,
                              );
                            }),
                        //***title and details section* */
                        title!.text
                            .size(16)
                            .color(darkFontGrey)
                            .fontFamily(semibold)
                            .make(),
                        10.heightBox,
                        //**raing*** */
                        VxRating(
                          //doi chuoi thanh so
                          value: double.parse(data['p-rating']),
                          onRatingUpdate: (value) {},
                          normalColor: textfieldGrey,
                          selectionColor: golden,
                          count: 5,
                          maxRating: 5,
                          size: 25,
                        ),
                        10.heightBox,
                        "${data['p_price']}"
                            .numCurrency
                            .text
                            .color(redColor)
                            .fontFamily(bold)
                            .size(18)
                            .make(),
                        10.heightBox,
                        //***Comment* */
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Seller"
                                    .text
                                    .blue500
                                    .fontFamily(semibold)
                                    .make(),
                                5.heightBox,
                                "${data['p_seller']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make()
                              ],
                            )),
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.message_rounded,
                                  color: darkFontGrey),
                            )
                          ],
                        )
                            .box
                            .height(69)
                            .padding(const EdgeInsets.symmetric(horizontal: 16))
                            .color(textfieldGrey)
                            .make(),
                        //***colors selection */
                        20.heightBox,
                        Obx(
                          () => Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Color:"
                                        .text
                                        .size(18)
                                        .color(blackFont)
                                        .make(),
                                  ),
                                  Row(
                                    children: List.generate(
                                        data['p-colors'].length,
                                        (index) => Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                VxBox()
                                                    .size(40, 40)
                                                    .roundedFull
                                                    .color(Color(
                                                            data['p-colors']
                                                                [index])
                                                        .withOpacity(1.0))
                                                    .margin(const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 6))
                                                    .make()
                                                    .onTap(() {
                                                  controller
                                                      .changeColorIndex(index);
                                                }),
                                                Visibility(
                                                    visible: index ==
                                                        controller
                                                            .colorIndex.value,
                                                    child: const Icon(
                                                        Icons.done,
                                                        color: Colors.white)),
                                              ],
                                            )),
                                  )
                                ],
                              ).box.padding(const EdgeInsets.all(8)).make(),
                              //***Quantity row */
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Quantity:"
                                        .text
                                        .size(18)
                                        .color(blackFont)
                                        .make(),
                                  ),
                                  Obx(
                                    () => Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              controller.decreaseQuantity();
                                              controller.calculateTotalPrice(
                                                  int.parse(data['p_price']));
                                            },
                                            icon: const Icon(Icons.remove)),
                                        controller.quantity.value.text
                                            .size(17)
                                            .color(darkFontGrey)
                                            .fontFamily(bold)
                                            .make(),
                                        IconButton(
                                            onPressed: () {
                                              controller.increaseQuantity(
                                                  int.parse(
                                                      data['p_quantity']));
                                              controller.calculateTotalPrice(
                                                  int.parse(data['p_price']));
                                            },
                                            icon: const Icon(Icons.add)),
                                        10.widthBox,
                                        "(${data['p_quantity']} available)"
                                            .text
                                            .color(darkFontGrey)
                                            .make(),
                                      ],
                                    ),
                                  ),
                                ],
                              ).box.padding(const EdgeInsets.all(8)).make(),
                              //***total quantity */
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Total:"
                                        .text
                                        .size(20)
                                        .fontFamily(bold)
                                        .color(blue1)
                                        .make(),
                                  ),
                                  "${controller.totalPrice.value}"
                                      .text
                                      .color(redColor)
                                      .size(16)
                                      .fontFamily(bold)
                                      .make()
                                ],
                              ).box.padding(const EdgeInsets.all(8)).make(),
                            ],
                          ).box.white.shadowSm.make(),
                        ),
                        //***Description section */
                        10.heightBox,
                        "Description"
                            .text
                            .size(17)
                            .color(darkFontGrey)
                            .fontFamily(semibold)
                            .make(),
                        10.heightBox,
                        "${data['p-desc']}"
                            .text
                            .size(15)
                            .color(darkFontGrey)
                            .make(),
                      ],
                    ),
                  )),
            ),
            SizedBox(
                width: double.infinity,
                height: 60,
                child: ourButton(
                    color: redColor,
                    onPress: () {
                      controller.addToCart(
                          color: data['p-colors'][controller.colorIndex.value],
                          context: context,
                          img: data['p-imgs'][0],
                          qty: controller.quantity.value,
                          sellername: data['p_seller'],
                          title: data['p_name'],
                          tprice: controller.totalPrice.value);
                      VxToast.show(context, msg: "Added to cart");
                    },
                    textColor: whiteColor,
                    title: "Add to cart"))
          ])),
    );
  }
}
