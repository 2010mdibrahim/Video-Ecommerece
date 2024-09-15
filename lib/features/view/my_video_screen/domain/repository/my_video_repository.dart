

import '../../../../../../core/source/model/api_response.dart';
import '../../../reels/data/model/reels_model.dart';
import '../../data/model/my_video_model.dart';
import '../../data/source/my_video_service.dart';
abstract class MyVideoRepository {
  final MyVideoService myVideoService;

  MyVideoRepository(this.myVideoService);

  Future<Response<AllReelsModel>?> myVideoPass();
}
