import '../repository/reels_repository.dart';

abstract class ReelsUseCase {
  final ReelsRepository reelsRepository;

  ReelsUseCase(this.reelsRepository);
}

abstract class LikeUseCase {
  final LikeRepository likeRepository;

  LikeUseCase(this.likeRepository);
}

abstract class AddToCartUseCase {
  final AddToCartRepository addToCartRepository;

  AddToCartUseCase(this.addToCartRepository);
}

abstract class RemoveToCartUseCase {
  final RemoveToCartRepository removeToCartRepository;

  RemoveToCartUseCase(this.removeToCartRepository);
}

