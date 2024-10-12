import 'package:e_commerce/core/core/extensions/extensions.dart';
import 'package:e_commerce/core/utils/appStyle.dart';
import 'package:e_commerce/features/view/homepage/presentation/controller/home_controller.dart';
import 'package:e_commerce/features/widget/cached_image_network/custom_cached_image_network.dart';
import 'package:e_commerce/features/widget/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendListPage extends StatelessWidget {
  const FriendListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (homeController) {
          return Scaffold(
            appBar: CustomAppBar(title: "Friends"),
            body: homeController.isFrientListLoading.value == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : homeController.frientListModel.value.users?.isEmpty ?? false
                    ? Center(
                        child: CustomSimpleText(
                          text: "No Data Found",
                          alignment: Alignment.center,
                        ),
                      )
                    : ListView.builder(
                        itemCount:
                            homeController.frientListModel.value.users?.length,
                        itemBuilder: (_, index) {
                          var item = homeController
                              .frientListModel.value.users?[index];
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CustomCachedImageNetwork(
                                      imageUrl:
                                          "http://erp.mahfuza-overseas.com/trending-house/assets/images/users/${item?.photo}",
                                      height: 50,
                                      weight: 50,
                                    ),
                                  ),
                                  10.pw,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                       CustomSimpleText(
                                        text: item?.name,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Colors.black,
                                        alignment: Alignment.center,
                                      ),
                                      Visibility(
                                        visible: item?.city == null ? false : true,
                                        child: CustomSimpleText(
                                          text: item?.city ?? '',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Colors.black,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                      Visibility(
                                        visible: item?.country == null ? false : true,
                                        child: CustomSimpleText(
                                          text: item?.country ?? '',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Colors.black,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                      Visibility(
                                        visible: item?.email == null ? false : true,
                                        child: CustomSimpleText(
                                          text: item?.email ?? '',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Colors.black,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
          );
        });
  }
}
