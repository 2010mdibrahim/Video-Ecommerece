import '../repository/product_category_repository.dart';

abstract class ProductCategoryUseCase {
  final ProductCategoryRepository productCategoryRepository;

  ProductCategoryUseCase(this.productCategoryRepository);
}
abstract class ProductCategoryWiseProductUseCase {
  final ProductCategoryRepository productCategoryRepository;

  ProductCategoryWiseProductUseCase(this.productCategoryRepository);
}
abstract class productDetailsUseCase {
  final ProductCategoryRepository productCategoryRepository;

  productDetailsUseCase(this.productCategoryRepository);
}

