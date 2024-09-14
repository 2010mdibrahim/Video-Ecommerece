import 'package:e_commerce/core/core/extensions/extensions.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/features/widget/custom_appbar/custom_appbar.dart';
import 'package:e_commerce/features/widget/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../../core/di/app_component.dart';
import '../../../../../core/network/configuration.dart';
import '../../../../../core/utils/appStyle.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_sizes.dart';
import '../../../../widget/cached_image_network/custom_cached_image_network.dart';
import '../controller/all_product_controller.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage({super.key});
  // var controller = locator<AllProductController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AllProductController(),
      builder: (controller) {
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
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: AppSizes.newSize(26.1),
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
                                              "${NetworkConfiguration.baseUrl.replaceAll("api/", '')}assets/images/thumbnails/${controller.image.value}",
                                          height: AppSizes.newSize(21.1),
                                          weight:
                                              MediaQuery.of(context).size.width,
                                      boxfit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  5.ph,
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: CustomText(
                                        text:
                                            "${controller.productCategoryWiseProductDetailsModel.value.itemDetail?.name}",
                                      ),
                                    ),
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
                                    child: InkWell(
                                      onTap: (){
                                        controller.image.value = item?.thumbnail;
                                      },
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
                                    ),
                                  );
                                },
                              ),
                            ),
                            90.ph,
                            InkWell(
                              onTap: ()=> controller.chooseFile(context),
                              child:  Center(
                                child: Container(
                                  height: 86,
                                  width: 86,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(500),
                                    color: Colors.grey.withOpacity(0.55),
                                  ),
                                  child:  Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: CustomText(
                                        text:  (controller.paths?.path?.isNotEmpty ??
                                            false || controller.paths != null) ? "Upload": "Choose File",
                                        fontSize: 12,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            20.ph,
                            if (controller.a.value != 0.0)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularPercentIndicator(
                                  animation: false,
                                  radius: 100.0,
                                  lineWidth: 10.0,
                                  percent: (controller.a.value / 2.0).clamp(
                                      0.0, 1.0), // Ensure progress is between 0 and 1
                                  backgroundColor: Colors.grey,
                                  progressColor: Colors.blue,
                                  center: Text(
                                    "${((controller.a.value / 2.0) * 100).round()}%", // Convert progress to percentage
                                    style: const TextStyle(fontSize: 12.0),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
              ),
          floatingActionButton: (controller.paths?.path?.isNotEmpty ??
              false || controller.paths != null) ? InkWell(
            onTap: (){
              controller.upload(
                  filepath: controller.paths,
                  type: '',
                  fileSize: controller.videoData?.filesize,
                  context: context,
              id: controller.productCategoryWiseProductDetailsModel.value.itemDetail?.id
              );
            },
                child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.green
                        ),
                        child: Icon(Icons.cloud_upload, size: 30,)
                      ),
              ) : SizedBox(),
            ),
        );
      }
    );
  }
}
