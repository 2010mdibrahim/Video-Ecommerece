import 'package:e_commerce/features/view/my_video_screen/data/model/my_video_model.dart';
import '../../../../../../core/source/model/api_response.dart';
import '../../../reels/data/model/reels_model.dart';
import '../../domain/repository/my_video_repository.dart';
import '../source/my_video_service.dart';
class MyVideoRepositoryImpl extends MyVideoRepository {
  MyVideoRepositoryImpl(MyVideoService myVideoService) : super(myVideoService);

  @override
  Future<Response<AllReelsModel>?> myVideoPass() async {
    Response<AllReelsModel>? apiResponse;
    apiResponse = await myVideoService.myVideoPass();
    return apiResponse;
  }
}
