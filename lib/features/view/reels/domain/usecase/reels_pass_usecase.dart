
import 'package:dio/dio.dart'as dio;

import '../../../../../../core/source/model/api_response.dart';
import '../../data/model/reels_model.dart';
import 'reels_usecase.dart';

class ReelsPassUseCase extends ReelsUseCase {
  ReelsPassUseCase(super.reelsRepository);

  Future<Response<AllReelsModel>?> call() async {
    var response = await reelsRepository.reelsPass();
    return response;
  }
}

