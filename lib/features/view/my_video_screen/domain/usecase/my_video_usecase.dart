import '../repository/my_video_repository.dart';

abstract class MyVideoUseCase {
  final MyVideoRepository myVideoRepository;

  MyVideoUseCase(this.myVideoRepository);
}

