import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shop_app/comtrollers/home_controllers.dart';
import 'package:shop_app/consts/consts.dart';

class CartController extends GetxController {
  //text controller shipping detais.
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalcodeController = TextEditingController();
  var phoneController = TextEditingController();
  var totalP = 0.obs;
  late dynamic productSnapshot;
  var products = [];
  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  placeMyOrder({required totalAmount}) async {
    await getProductDetails();
    await firestore.collection(ordersColection).doc().set({
      'order_code': "233981237",
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_city': cityController.text,
      'order_by_state': stateController.text,
      'order_by_postalcode': postalcodeController.text,
      'order_by_phone': phoneController.text,
      'order_place': true,
      'order_confirmed': false,
      'order_delivered': false,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products)
    });
  }

// lay san pham gio hang nap vao mang products
  getProductDetails() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'color': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'qty': productSnapshot[i]['qty'],
        'title': productSnapshot[i]['title'],
      });
    }
    // print(products);
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollecttion).doc(productSnapshot[i].id).delete();
    }
  }
}
