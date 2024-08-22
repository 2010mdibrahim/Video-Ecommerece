import '../repository/product_category_repository.dart';

abstract class ProductCategoryUseCase {
  final ProductCategoryRepository productCategoryRepository;

  ProductCategoryUseCase(this.productCategoryRepository);
}

