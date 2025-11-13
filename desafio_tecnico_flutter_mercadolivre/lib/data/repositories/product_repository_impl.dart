import '../../domain/entities/product_details_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/meli_api_datasources.dart';

class ProductRepositoryImpl implements ProductRepository {
  final MeliApiDataSource dataSource;

  ProductRepositoryImpl({required this.dataSource});

  @override
  Future<List<ProductEntity>> searchProducts(String query) async {
    try {
      final models = await dataSource.searchProducts(query);
      return models;
    } on ServerException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<ProductDetailsEntity> getProductDetails(String id) async {
    try {
      final model = await dataSource.getProductDetails(id);
      return model;
    } on ServerException catch (e) {
      throw Exception(e.message);
    }
  }
}
