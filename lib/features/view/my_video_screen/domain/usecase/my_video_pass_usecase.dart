
import 'package:dio/dio.dart'as dio;

import '../../../../../../core/source/model/api_response.dart';
import '../../../reels/data/model/reels_model.dart';
import '../../data/model/my_video_model.dart';
import 'my_video_usecase.dart';

class MyVideoPassUseCase extends MyVideoUseCase {
  MyVideoPassUseCase(super.myVideoRepository);

  Future<Response<AllReelsModel>?> call() async {
    var response = await myVideoRepository.myVideoPass();
    return response;
  }
}

