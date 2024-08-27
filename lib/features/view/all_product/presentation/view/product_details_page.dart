import 'package:e_commerce/core/core/extensions/extensions.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/features/widget/custom_appbar/custom_appbar.dart';
import 'package:e_commerce/features/widget/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/di/app_component.dart';
import '../../../../../core/network/configuration.dart';
import '../../../../../core/utils/app_sizes.dart';
import '../../../../widget/cached_image_network/custom_cached_image_network.dart';
import '../controller/all_product_controller.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage({super.key});
  var controller = locator<AllProductController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: AppColors.slightWhite,
          appBar: CustomAppBar(
            title: "Product Details",
            onBackPressed: () {
              Navigator.pop(context);
            },
          ),
          body: SingleChildScrollView(
            child: controller.isProductDetailsLoading.value == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: AppSizes.newSize(23.1),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.withOpacity(0.6)),
                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CustomCachedImageNetwork(
                                      imageUrl:
                                          "${NetworkConfiguration.baseUrl.replaceAll("api/", '')}assets/images/thumbnails/${controller.productCategoryWiseProductDetailsModel.value.itemDetail?.thumbnail ?? ''}",
                                      height: AppSizes.newSize(21.1),
                                      weight:
                                          MediaQuery.of(context).size.width),
                                ),
                              ),
                              5.ph,
                              CustomText(
                                text:
                                    "${controller.productCategoryWiseProductDetailsModel.value.itemDetail?.name}",
                              ),
                              5.ph,
                            ],
                          ),
                        ),
                        10.ph,
                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller
                                  .productCategoryWiseProductDetailsModel
                                  .value
                                  .vendors
                                  ?.length,
                              itemBuilder: (_, index) {
                                var item = controller
                                    .productCategoryWiseProductDetailsModel
                                    .value
                                    .vendors?[index];
                                return SizedBox(
                                  height: 73,
                                  width: 90,
                                  child: Card(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CustomCachedImageNetwork(
                                        imageUrl:
                                            "${NetworkConfiguration.baseUrl.replaceAll("api/", '')}assets/images/thumbnails/${item?.thumbnail ?? ''}",
                                        height: 75,
                                        weight: 75,
                                        boxfit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        90.ph,
                        Center(
                          child: Container(
                            height: 86,
                            width: 86,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(500),
                              color: Colors.grey.withOpacity(0.55),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: CustomText(text: "Upload Video", fontSize: 12,textAlign: TextAlign.center,),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        ));
  }
}
