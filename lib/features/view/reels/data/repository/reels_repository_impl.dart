import 'package:e_commerce/features/view/my_video_screen/data/model/my_video_model.dart';
import '../../../../../../core/source/model/api_response.dart';
import '../../domain/repository/reels_repository.dart';
import '../model/reels_model.dart';
import '../source/reels_service.dart';
class ReelsRepositoryImpl extends ReelsRepository {
  ReelsRepositoryImpl(ReelsService reelsService) : super(reelsService);

  @override
  Future<Response<AllReelsModel>?> reelsPass() async {
    Response<AllReelsModel>? apiResponse;
    apiResponse = await reelsService.reelsPass();
    return apiResponse;
  }
}
