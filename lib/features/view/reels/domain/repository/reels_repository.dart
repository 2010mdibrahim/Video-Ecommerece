

import '../../../../../../core/source/model/api_response.dart';
import '../../data/model/reels_model.dart';
import '../../data/source/reels_service.dart';
abstract class ReelsRepository {
  final ReelsService reelsService;

  ReelsRepository(this.reelsService);

  Future<Response<AllReelsModel>?> reelsPass();
}
