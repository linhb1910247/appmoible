import 'package:get/get.dart';

import '../../comtrollers/product_controller.dart';
import '../../consts/consts.dart';
import '../../consts/list.dart';
import '../../widgets_common/bg_widget.dart';
import 'category_details.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              title: categories.text.fontFamily(bold).black.make(),
            ),
            body: Container(
                padding: const EdgeInsets.all(12),
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 7,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 200,
                    ),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Image.asset(
                            categoryImages[index],
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                          10.heightBox,
                          categoryList[index]
                              .text
                              .color(darkFontGrey)
                              .align(TextAlign.center)
                              .make(),
                        ],
                      )
                          .box
                          .white
                          .rounded
                          .clip(Clip.antiAlias)
                          .outerShadow
                          .make()
                          .onTap(() {
                        controller.getSubCategories(categoryList[index]);
                        Get.to(
                            () => CategoryDetails(title: categoryList[index]));
                      });
                    }))));
  }
}
