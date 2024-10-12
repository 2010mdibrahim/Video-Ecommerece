import 'dart:convert';

import 'package:e_commerce/core/core/extensions/extensions.dart';
import 'package:e_commerce/core/utils/appStyle.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/utils/app_sizes.dart';
import 'package:e_commerce/features/view/reels/data/model/by_now_model.dart';
import 'package:e_commerce/features/view/reels/data/model/like_model.dart';
import 'package:e_commerce/features/view/reels/domain/usecase/reels_pass_usecase.dart';
import 'package:e_commerce/features/widget/custom_toast/custom_toast.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/di/app_component.dart';
import '../../../../../core/model/dropdown_model.dart';
import '../../../../../core/source/dio_client.dart';
import '../../../../widget/custom_textfield/custom_textfield.dart';
import '../../../all_product/presentation/controller/all_product_controller.dart';
import '../../../homepage/data/model/coupon_code_model.dart';
import '../../../homepage/domain/repository/home_repository.dart';
import '../../../homepage/domain/usecase/home_pass_usecase.dart';
import '../../../homepage/presentation/controller/home_controller.dart';
import '../../data/model/add_to_cart_model.dart';
import '../../data/model/cart_item_delete_model.dart';
import '../../data/model/reels_model.dart';
import '../../domain/repository/reels_repository.dart';

class ReelsController extends GetxController {
  var isLoading = false.obs;
  var isAddToCartLoading = false.obs;
  var reelsModel = AllReelsModel().obs;
  var couponCodeModel = CouponCodeModel().obs;
  var buyNowModel = BuyNowModel().obs;
  var isCouponClicked = false.obs;
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
  var quantity = 1.obs;
  // var fullNameController = TextEditingController().obs;
  // var phoneNumberController = TextEditingController().obs;
  // var detailAddressController = TextEditingController().obs;
  // var orderNotesController = TextEditingController().obs;
  // var couponCodeController = TextEditingController().obs;
  var shippingSelectedValue = 0.obs;
  var shippingSelectedValueId = 0.obs;
  var packagingSelectedValue = 1.obs;
  var packagingSelectedValueId = 1.obs;
  var isContinueClicked = false.obs;
  var shippingDifferentAddress = false.obs;
  var creatorName = ''.obs;
  var productId = ''.obs;
  var catName = ''.obs;
  var productName = ''.obs;
  var productPrice = ''.obs;
  var creatorPhoto = ''.obs;
  RxString selectSize = ''.obs;
  var selectSizeId = 0.obs;
  var selectSizePrice = ''.obs;
  var selectSizeColor = ''.obs;
  var selectSizeQty = ''.obs;
  var selectSizeKey = ''.obs;
  var isCheckOutDataLoding = false.obs;
  var isBuyNowLoading = false.obs;
  DropdownModel? selectedDropdown;
  var allProductController = Get.put(AllProductController());
  var homeController = locator<HomeController>();
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
        selectSize.value = reelsModel.value?.data?.first.size?.first.toString() ?? '';
        totalMRP.value = int.parse(reelsModel.value?.data?.first.sizePrice?.first ?? '');
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

  }
  couponCodeFunction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("value of coupon");
    try {
      if (homeController.couponCodeController.value.text.isNotEmpty) {
        isCheckOutDataLoding.value = true;
        var carts = {
          "code": homeController.couponCodeController.value.text,
          "total": totalMRP.value.toString(),
          "shipping_cost": "0",
          "exist_code": session.getExistingCode ?? '',
          "cart": prefs.getString('cart') ?? ''
        };
        CouponCodePassUseCase codePassUseCase =
        CouponCodePassUseCase(locator<HomeRepository>());
        var response = await codePassUseCase(data: carts);
        if (response?.data != null && response?.data is CouponCodeModel) {
          couponCodeModel.value = response?.data ?? CouponCodeModel();
          session.setExistingCode = couponCodeModel.value.existCode;
          print(response?.data);
        } else {
          // ErrorDialog(navigatorKey.currentContext!, msg: "No Coupon Available");
        }
      }
    } catch (e) {
      isCheckOutDataLoding.value = false;
      print("This is an error: ${e.toString()}");
    } finally {
      isCheckOutDataLoding.value = false;
    }
  }
  Future <void> buyNowFunction({int? videoID}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("value of coupon id ${productId.value}");
    print("value of coupon qty ${selectSizeQty.value}");
    print("value of coupon size ${selectSize.value}");
    print("value of coupon color ${selectSizeColor.value}");
    print("value of coupon price ${selectSizePrice.value}");
    print("value of coupon key ${selectSizeKey.value}");
    print("value of coupon video id${videoID.toString()}");
    // try {
    //   isBuyNowLoading.value = true;
    var carts = {
      "id": productId.value.toString(),
      "qty": quantity.value.toString(),
      "size": selectSize.value.toString(),
      "color": selectSizeColor.value.isEmpty ? "" : selectSizeColor.value.toString(),
      "size_qty": selectSizeQty.value.toString(),
      "size_price": selectSizePrice.value.toString(),
      "size_key": selectSizeKey.value.toString(),
      "keys": "",
      "values": "",
      "prices": "",
      "video_id": videoID.toString()
    };

        var cartss = {
            "id": "200" ,
            "qty": "1",
            "size": "M",
            "color":"",
            "size_qty":"1",
            "size_price": "300",
            "size_key":"1",
            "keys":"",
            "values":"",
            "prices":"",
            "video_id": "14"
          };
        print("this data ${carts}");
      BuyNowPassUseCase buyNowPassUseCase =
      BuyNowPassUseCase(locator<BuyNowRepository>());
        var response = await buyNowPassUseCase(carts);
        if (response?.data != null && response?.data is BuyNowModel) {
          buyNowModel.value = response?.data ?? BuyNowModel();
          await prefs.setString('buyCart', response?.data?.buyCart ?? '');
          print("cart ${prefs.getString("buyCart")}");
          print(response?.data);
        } else {
          errorToast(context: navigatorKey.currentContext!, msg: "Something went wrong. Please try again later.");
        }

    // } catch (e) {
    //   isBuyNowLoading.value = false;
    //   print("This is an error: ${e.toString()}");
    // } finally {
    //   isBuyNowLoading.value = false;
    // }
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
                          controller: homeController.fullNameController.value,
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
                          controller: homeController.phoneNumberController.value,
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
                    controller: homeController.detailAddressController.value,
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
  void productInformation(BuildContext context, {required String msg}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Less curved corners
          ),
          title: CustomSimpleText(
            text: "Missing Information",
            color: Colors.red,
            fontSize: AppSizes.size17,
          ),
          content: SingleChildScrollView(
            // Allows the content to scroll if it exceeds available height
            child: Column(
              mainAxisSize:
              MainAxisSize.min, // Ensures dialog adjusts to content height
              children: [
                CustomSimpleText(
                  text: msg,
                  color: Colors.black,
                  fontSize: AppSizes.size16,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: CustomSimpleText(
                alignment: Alignment.centerRight,
                text: "Close",
                color: Colors.red,
                fontSize: AppSizes.size16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
  void incrementQuantity(){

    quantity.value++;

  update();
  }
  void decrementQuantity(){
  if(quantity.value > 1){
    quantity.value--;
  }
  }

  String? getCurrentPrice({List<String>? data}) {
    if(data?.length == 1){
      return data?[0];
    }else{
      return data?[selectSizeId.value]; // Assuming the same color for all sizes
    }
    // return data?[selectSizeId.value]; // Get the price based on the selected index
  }

  String? getCurrentQty({List<String>? data}) {
    if(data?.length == 1){
      return data?[0];
    }else{
      return data?[selectSizeId.value]; // Assuming the same color for all sizes
    }
    // return data?[selectSizeId.value]; // Get the quantity based on the selected index
  }
  //
  String? getCurrentColor({List<String>? data}) {
    if(data?.length == 1){
      return data?[0].replaceAll('#', '0xff');
    }else{
    return data?[selectSizeId.value].replaceAll('#', '0xff'); // Assuming the same color for all sizes
    }
  }
}
