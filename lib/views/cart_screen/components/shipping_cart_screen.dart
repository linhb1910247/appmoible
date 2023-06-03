import 'package:get/get.dart';
import 'package:shop_app/consts/consts.dart';
import 'package:shop_app/widgets_common/custom_textfield.dart';
import 'package:shop_app/widgets_common/out_button.dart';

import '../../../comtrollers/cart_contronller.dart';
import '../../home_screen/home.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: 'Shipping info'
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: ourButton(
            onPress: () async {
              await controller.placeMyOrder(
                  totalAmount: controller.totalP.value);
              await controller.clearCart();
              Get.offAll(const Home());
              // ignore: use_build_context_synchronously
              VxToast.show(context, msg: "Order successfully");
            },
            color: redColor,
            textColor: whiteColor,
            title: "Checkout",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              customTextField(
                  hint: "Address",
                  isPass: false,
                  title: "Address",
                  controller: controller.addressController),
              customTextField(
                  hint: "City",
                  isPass: false,
                  title: "City",
                  controller: controller.cityController),
              customTextField(
                  hint: "State",
                  isPass: false,
                  title: "State",
                  controller: controller.stateController),
              customTextField(
                  hint: "Postal Code",
                  isPass: false,
                  title: "Postal Code",
                  controller: controller.postalcodeController),
              customTextField(
                  hint: "Phone",
                  isPass: false,
                  title: "Phone",
                  controller: controller.phoneController),
            ],
          ),
        ));
  }
}
