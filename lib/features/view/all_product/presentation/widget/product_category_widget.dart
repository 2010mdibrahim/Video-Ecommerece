import 'package:e_commerce/core/di/app_component.dart';
import 'package:e_commerce/core/network/configuration.dart';
import 'package:e_commerce/core/utils/appStyle.dart';
import 'package:e_commerce/core/utils/app_assets.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/utils/app_sizes.dart';
import 'package:e_commerce/features/view/all_product/data/model/product_category_model.dart';
import 'package:e_commerce/features/view/all_product/presentation/controller/all_product_controller.dart';
import 'package:e_commerce/features/widget/cached_image_network/custom_cached_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../../../core/routes/route_name.dart';
import '../../../../../core/routes/router.dart';
import '../../../../../main.dart';

class ProductCategoryWidget extends StatelessWidget {
  var controller = locator<AllProductController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllProductController>(
        init: AllProductController(),
        builder: (c) {
          return Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: controller.isLoading.value ? Center(child: CircularProgressIndicator(),) : MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                itemCount: controller.productCategoryList.length,
                crossAxisSpacing: 8,
                itemBuilder: (context, index) {
                  var item = controller.productCategoryList[index];
                  print(
                      "${NetworkConfiguration.baseUrl.replaceAll("api/", '')}assets/images/categories/${item.image ?? ''}");
                  return InkWell(
                    onTap: (){
                      var data = {
                        "cat_id" : item.id.toString(),
                      };
                      controller.categoryWiseProductItems(data: data).then((value){
                        RouteGenerator.pushNamed(
                            navigatorKey.currentContext!, Routes.productCategoryWise);
                      });
                    },
                    child: Stack(
                      children: [
                        Tile(index: index + 1, extent: 190, item: item),
                        Positioned(
                          right: 15,
                          top: 10,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: (index) % 2 == 0 ? 0 : 20),
                            child: Transform.rotate(
                              angle: 20 * 3.1415926535897932 / 180,
                              child: CustomCachedImageNetwork(
                                  imageUrl:
                                      "${NetworkConfiguration.baseUrl.replaceAll("api/", '')}assets/images/categories/${item.image ?? ''}",
                                  height: AppSizes.size42,
                                  weight: AppSizes.size42),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}

class Tile extends StatelessWidget {
  final int index;
  final double extent;
  final ProductCategoryModel item;

  Tile({required this.index, required this.extent, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: (index) % 2 == 0 ? 60 : 40),
      child: Padding(
        padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 143,
            decoration: BoxDecoration(
              color: AppColors.allProductCardColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26.withOpacity(0.16),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: CustomSimpleText(
                text: item.name ?? '',
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
