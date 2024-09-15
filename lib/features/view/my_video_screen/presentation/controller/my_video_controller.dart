import 'package:e_commerce/features/view/my_video_screen/data/model/my_video_model.dart';
import 'package:e_commerce/features/view/reels/presentation/controller/reels_controller.dart';
import 'package:get/get.dart';

import '../../../../../core/di/app_component.dart';
import '../../../reels/data/model/reels_model.dart';
import '../../domain/repository/my_video_repository.dart';
import '../../domain/usecase/my_video_pass_usecase.dart';

class MyVideoController extends GetxController{

var isLoading = false.obs;
// var myVideoModel = AllReelsModel().obs;

var reelsController = locator<ReelsController>();
  @override
  void onInit() {
    myVideoList();
    super.onInit();
  }

  myVideoList() async {
    try {
      isLoading.value = true;
      MyVideoPassUseCase productCategoryUseCase =
      MyVideoPassUseCase(locator<MyVideoRepository>());
      var response = await productCategoryUseCase();
      if (response?.data != null && response?.data is AllReelsModel) {
        reelsController.reelsModel.value = response?.data ?? AllReelsModel();
      } else {
        print('No data found');
      }
    } catch (e) {
      print("This is an error: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}