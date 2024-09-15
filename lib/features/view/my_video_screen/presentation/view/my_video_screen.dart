import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/features/view/my_video_screen/presentation/controller/my_video_controller.dart';
import 'package:e_commerce/features/view/reels/presentation/controller/reels_controller.dart';
import 'package:e_commerce/features/widget/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../../../core/di/app_component.dart';
import '../../../../../core/network/configuration.dart';
import '../../../../../core/routes/route_name.dart';
import '../../../../../core/routes/router.dart';
import '../../../../../core/utils/app_sizes.dart';
import '../../../../widget/cached_image_network/custom_cached_image_network.dart';

class MyVideoScreen extends StatelessWidget {
  MyVideoScreen({super.key});
  var controller = locator<MyVideoController>();
  var reelsController = locator<ReelsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slightWhite,
      appBar: CustomAppBar(
        title: "My Video",
        textAlign: TextAlign.start,
        isTextCenter: false,
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : MasonryGridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  itemCount: reelsController.reelsModel.value.data?.length,
                  crossAxisSpacing: 8,
                  itemBuilder: (context, index) {
                    var item = reelsController.reelsModel.value.data?[index];
                    print(
                        "${NetworkConfiguration.baseUrl.replaceAll("api/", '')}assets/videos/thumbnail/${item?.thumbnail ?? ''}");
                    return InkWell(
                      onTap: () {
                        // controller.productCategoryDetails(itemName: item?.slug ?? '');
                        RouteGenerator.pushNamed(context, Routes.reelsScreen);
                        reelsController.indexFromMyVideo.value = index;
                        controller.myVideoList();
                      },
                      child: SizedBox(
                        height: 200,
                        child: CustomCachedImageNetwork(
                            imageUrl:
                                "${NetworkConfiguration.baseUrl.replaceAll("api/", '')}${item?.thumbnail ?? ''}",
                            height: AppSizes.size42,
                            weight: AppSizes.size42),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
