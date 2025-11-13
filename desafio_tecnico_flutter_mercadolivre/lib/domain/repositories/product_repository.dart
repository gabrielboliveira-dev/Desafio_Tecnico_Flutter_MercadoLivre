import '../entities/product_details_entity.dart';
import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> searchProducts(String query);

  Future<ProductDetailsEntity> getProductDetails(String id);
}
