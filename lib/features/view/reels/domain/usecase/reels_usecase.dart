import '../repository/reels_repository.dart';

abstract class ReelsUseCase {
  final ReelsRepository reelsRepository;

  ReelsUseCase(this.reelsRepository);
}

