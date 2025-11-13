import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.title,
    required super.thumbnail,
    required super.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final String thumbnailUrl = (json['thumbnail'] as String? ?? '')
        .replaceFirst('http://', 'https://');

    return ProductModel(
      id: json['id'] ?? '',
      title: json['title'] ?? 'Sem Título',
      thumbnail: thumbnailUrl,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
