import 'package:shop_app/views/home_screen/components/featured_button.dart';
import 'package:shop_app/widgets_common/home_button.dart';

import '../../consts/consts.dart';
import '../../consts/list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          //*******search********
          Container(
            alignment: Alignment.center,
            height: 60,
            color: lightGrey,
            child: TextFormField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search),
                filled: true,
                fillColor: whiteColor,
                hintText: searchanything,
                hintStyle: TextStyle(color: textfieldGrey),
              ),
            ),
          ),
          10.heightBox,
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  //******swipers brands******
                  VxSwiper.builder(
                      //******bang cuon******
                      aspectRatio: 16 /
                          9, //******dieu chinh kich thuoc cua child theo khung hinh*******
                      autoPlay: true,
                      height: 150,
                      enableInfiniteScroll: true, // ban cuon
                      itemCount: slidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(slidersList[index], fit: BoxFit.fill)
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),
                  15.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        2,
                        (index) => homeButtons(
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 2.5,
                            icon: index == 0 ? icTodaysDeal : icFlashDeal,
                            title: index == 0 ? todaysDeal : flashsale)),
                  ),
                  //*********2nd swipper***********
                  10.heightBox,
                  VxSwiper.builder(
                      //****bang cuon*****
                      aspectRatio: 16 /
                          9, // ********dieu chinh kich thuoc cua child theo khung hinh*******
                      autoPlay: true,
                      height: 150,
                      enableInfiniteScroll: true, // ban cuon
                      itemCount: secondSliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(secondSliderList[index],
                                fit: BoxFit.fill)
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),
                  //category button
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => homeButtons(
                              height: context.screenHeight * 0.15,
                              width: context.screenWidth / 3.5,
                              icon: index == 0
                                  ? icTopCategories
                                  : index == 1
                                      ? icBrands
                                      : icTopSeller,
                              title: index == 0
                                  ? topCategories
                                  : index == 1
                                      ? brands
                                      : topSeller,
                            )),
                  ), //
                  //******featured categories**************
                  20.heightBox,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: featuredCategory.text
                        .color(darkFontGrey)
                        .size(18)
                        .fontFamily(semibold)
                        .make(),
                  ),
                  20.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          3,
                          (index) => Column(
                                children: [
                                  featuredButton(
                                    title: featuredTitlesS1[index],
                                    icon: featuredImageS1[index],
                                  ),
                                  10.heightBox,
                                  featuredButton(
                                    title: featuredTitlesS2[index],
                                    icon: featuredImageS2[index],
                                  ),
                                ],
                              )).toList(),
                    ),
                  ),
                  //*****featured product************
                  20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: const BoxDecoration(color: blue1),
                    child: Column(
                      //
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featuredProduct.text.white
                            .fontFamily(bold)
                            .size(18)
                            .make(),
                        10.heightBox,
                        //***product list featured*******
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                6,
                                (index) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          imgao1,
                                          width: 150,
                                          fit: BoxFit.fill,
                                        ),
                                        10.heightBox,
                                        "Ao thun nam"
                                            .text
                                            .fontFamily(semibold)
                                            .color(darkFontGrey)
                                            .make(),
                                        10.heightBox,
                                        "\$600"
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
                                          const EdgeInsets.symmetric(
                                              horizontal: 4),
                                        )
                                        .roundedSM
                                        .padding(const EdgeInsets.all(8))
                                        .make()),
                          ),
                        )
                      ],
                    ),
                  ),
                  10.heightBox,
                  //**third swipper **/
                  VxSwiper.builder(
                      //******bang cuon******
                      aspectRatio: 16 /
                          9, //******dieu chinh kich thuoc cua child theo khung hinh*******
                      autoPlay: true,
                      height: 150,
                      enableInfiniteScroll: true, // ban cuon
                      itemCount: slidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(slidersList[index], fit: BoxFit.fill)
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),
                  10.heightBox,
                  //****ALL Products******/
                  GridView.builder(
                      physics:
                          const NeverScrollableScrollPhysics(), //**ngan nguoi dung khong cuon listview */
                      shrinkWrap: true,
                      itemCount: 6,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        // hien thi du lieu dong
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        mainAxisExtent: 300,
                      ),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Image.asset(
                              imgao1,
                              height: 200,
                              width: 200,
                              fit: BoxFit.fill,
                            ),
                            const Spacer(),
                            "Ao thun nam"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            10.heightBox,
                            "\$600"
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
                            .padding(const EdgeInsets.all(12))
                            .make();
                      }),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
