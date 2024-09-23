import 'dart:convert';

import 'package:e_commerce/core/core/extensions/extensions.dart';
import 'package:e_commerce/core/utils/appStyle.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/utils/app_sizes.dart';
import 'package:e_commerce/features/view/reels/data/model/like_model.dart';
import 'package:e_commerce/features/view/reels/domain/usecase/reels_pass_usecase.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/di/app_component.dart';
import '../../../../../core/model/dropdown_model.dart';
import '../../../../widget/custom_textfield/custom_textfield.dart';
import '../../../all_product/presentation/controller/all_product_controller.dart';
import '../../data/model/add_to_cart_model.dart';
import '../../data/model/cart_item_delete_model.dart';
import '../../data/model/reels_model.dart';
import '../../domain/repository/reels_repository.dart';

class ReelsController extends GetxController {
  var isLoading = false.obs;
  var isAddToCartLoading = false.obs;
  var reelsModel = AllReelsModel().obs;
  // var addToCartListModel = AllReelsModel().obs;
  // RxList<AddToCartModel> addToCartListModel =  <AddToCartModel>[].obs;
  var addToCartModel = AddToCartModel().obs;
  var likeModel = LikeModel().obs;
  VideoPlayerController? videoPlayerController;
  var currentPage = 0.obs;
  var indexFromMyVideo = 0.obs;
  var pageController = PageController().obs;
  var orderNumber = 1.obs;
  var price = 100.obs;
  var priceSum = 0.obs;
  var totalMRP = 0.obs;
  var fullNameController = TextEditingController().obs;
  var phoneNumberController = TextEditingController().obs;
  var detailAddressController = TextEditingController().obs;
  var creatorName = ''.obs;
  var catName = ''.obs;
  var productName = ''.obs;
  var productPrice = ''.obs;
  var creatorPhoto = ''.obs;
  DropdownModel? selectedDropdown;
  var allProductController = Get.put(AllProductController());
  @override
  void onInit() {
    reelsVideos(videoCategoryId: 0);
    allProductController.productCategory();
    super.onInit();
  }

  Future reelsVideos({required int videoCategoryId}) async {
    // print("video category id ${box}");
    try {

      isLoading.value = true;
      var data = {
        "category_id": videoCategoryId,
      };
      reelsModel.value.data?.clear();
      ReelsPassUseCase reelsPassUseCase =
          ReelsPassUseCase(locator<ReelsRepository>());
      var response = await reelsPassUseCase(data);
      if (response?.data != null && response?.data is AllReelsModel) {
        reelsModel.value = response?.data ?? AllReelsModel();
        for (var item in reelsModel.value.data ?? []) {
          print("this is item ${item}");
        }
      } else {
        print('No data found');
      }
      isLoading.value = false;
    } catch (e) {
      print("This is an error: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
    update();
  }
  selectMenu(DropdownModel selectedValue){
    selectedDropdown = selectedValue;
    reelsVideos(videoCategoryId: selectedValue.id);
    print("the item ${selectedDropdown?.id}");
    update();
  }
  Future likeVideos({required int likeValue, required int videoId}) async {
    print("hudai");
    try {
      isLoading.value = true;
      LikePassUseCase likePassUseCase =
          LikePassUseCase(locator<LikeRepository>());
      var data = {
        'video_id': videoId,
        'like': likeValue,
      };
      var response = await likePassUseCase(data);
      if (response?.data != null && response?.data is LikeModel) {
        likeModel.value = response?.data ?? LikeModel();
      } else {
        print('No data found');
      }
    } catch (e) {
      print("This is an error: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
    update();
  }

  addToCartFunction(String productId, Data? videoData, int? id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isAddToCartLoading.value = true;
    AddToCartPassUseCase addToCartPassUseCase =
    AddToCartPassUseCase(locator<AddToCartRepository>());
    // await prefs.remove('addToCart');
    // await prefs.remove('cart');
    var response = await addToCartPassUseCase(
        productId, prefs.getString('cart') ?? '', id.toString());

    if (response?.data != null && response?.data is AddToCartModel) {
      addToCartModel.value = response?.data ?? AddToCartModel();


      // Update the existing product data
      ScaffoldMessenger.of(navigatorKey.currentContext!)
          .showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: CustomSimpleText(
          text: "Item updated successfully",
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: AppSizes.size18,
        ),
      ));

      await prefs.setString('cart', response?.data?.cart ?? '');

      isAddToCartLoading.value = false;
      update();
    }


    removeToCartFunction(String productId, AddToCartModel? item) async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        isAddToCartLoading.value = true;

        RemoveToCartPassUseCase removeToCartPassUseCase =
        RemoveToCartPassUseCase(locator<RemoveToCartRepository>());
        var response = await removeToCartPassUseCase(
            productId, prefs.getString('cart') ?? '');
        print("response of remove ${response?.data}");
        if (response?.data != null && response?.data is CartItemDeleteModel) {
          // removeFromCartList(item);
          await prefs.setString('cart', response?.data?.cart ?? '');
        } else {
          print('No data found');
        }
      } catch (e) {
        isAddToCartLoading.value = false;
        print("This is an error: ${e.toString()}");
      } finally {
        isAddToCartLoading.value = false;
      }
      update();
    }

    Future<List<AddToCartModel>?> getCartData() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? videoDataJson = prefs.getString('addToCart');

      if (videoDataJson != null) {
        // Decode the JSON string back to a List of dynamic
        List<dynamic> jsonData = jsonDecode(videoDataJson);

        // Convert the dynamic List to List<Data>
        List<AddToCartModel> dataList =
        jsonData.map((item) => AddToCartModel.fromJson(item)).toList();
        print("this is value : ${dataList}");
        // Assign the data to addToCartListModel


        return dataList;
      }
      return null;
    }


    void initController(String link) {
      videoPlayerController = VideoPlayerController.network(link)
        ..initialize().then((_) {
          videoPlayerController?.play();
        });
      update();
    }

    Future<void> onControllerChange(String link) async {
      if (videoPlayerController == null) {
        initController(link);
      } else {
        final oldController = videoPlayerController;
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await oldController?.dispose();
          initController(link);
        });
        videoPlayerController = null;
      }
      update();
    }

    void onPageChanged(int index) {
      currentPage.value = index;
      final videoData = reelsModel.value.data?[index].videoUrl ?? '';
      final videoUrl =
          "http://erp.mahfuza-overseas.com/trending-house/$videoData";
      onControllerChange(videoUrl);
      update();
    }
    Future<void> billingDetails(BuildContext context) async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(10),
            backgroundColor: Colors.white,
            title: CustomSimpleText(
              text: "Billing Details",
              fontWeight: FontWeight.bold,
              fontSize: AppSizes.size18,
              color: AppColors.black,
            ),
            content: SizedBox( // Constrain the width
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          child: CustomTextfield(
                            controller: fullNameController.value,
                            hintText: "Full Name",
                            lebelText: "Full Name",
                            labelLeftPadding: 14,
                          ),
                        ),
                      ),
                      10.pw,
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          child: CustomTextfield(
                            controller: phoneNumberController.value,
                            hintText: "Phone Number",
                            lebelText: "Phone Number",
                            labelLeftPadding: 14,
                            textInputType: TextInputType.number,
                          ),
                        ),
                      ),
                    ],
                  ),
                  15.ph,
                  SizedBox(
                    height: 45,
                    child: CustomTextfield(
                      controller: detailAddressController.value,
                      hintText: "Details Address",
                      lebelText: "Details Address",
                      labelLeftPadding: 14,
                    ),
                  ),

                  CustomSimpleText(
                    text: "Price Details",
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.size17,
                    color: AppColors.black,
                  ),
                  10.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomSimpleText(
                        text: "Total MRP",
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.size13,
                        color: AppColors.black,
                      ),
                      CustomSimpleText(
                        text: priceSum.value.toString(),
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.size13,
                        color: AppColors.black,
                      ),
                    ],
                  )

                ],
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Less curved corners
            ),
          );
        },
      );
    }
  }
}
