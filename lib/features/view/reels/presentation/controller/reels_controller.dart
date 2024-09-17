import 'package:e_commerce/features/view/my_video_screen/data/model/my_video_model.dart';
import 'package:e_commerce/features/view/reels/data/model/like_model.dart';
import 'package:e_commerce/features/view/reels/domain/usecase/reels_pass_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/di/app_component.dart';
import '../../data/model/reels_model.dart';
import '../../domain/repository/reels_repository.dart';

class ReelsController extends GetxController {
  var isLoading = false.obs;
  var reelsModel = AllReelsModel().obs;
  var likeModel = LikeModel().obs;
  VideoPlayerController? videoPlayerController;
  var currentPage = 0.obs;
  var indexFromMyVideo = 0.obs;
  var pageController = PageController().obs;
  var orderNumber = 1.obs;
  var price = 100.obs;
  var priceSum = 0.obs;
  var fullNameController = TextEditingController().obs;
  var phoneNumberController = TextEditingController().obs;
  var detailAddressController = TextEditingController().obs;
  @override
  void onInit() {
    reelsVideos();
    super.onInit();
  }

  reelsVideos() async {
    print("hudai");
    try {
      isLoading.value = true;
      ReelsPassUseCase reelsPassUseCase =
          ReelsPassUseCase(locator<ReelsRepository>());
      var response = await reelsPassUseCase();
      if (response?.data != null && response?.data is AllReelsModel) {
        reelsModel.value = response?.data ?? AllReelsModel();

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
