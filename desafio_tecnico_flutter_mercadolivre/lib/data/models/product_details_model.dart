import '../../domain/entities/product_details_entity.dart';

class ProductDetailsModel extends ProductDetailsEntity {
  ProductDetailsModel({
    required super.id,
    required super.title,
    required super.price,
    required super.pictures,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    final List<String> pictureUrls = (json['pictures'] as List<dynamic>? ?? [])
        .map(
          (pic) =>
              (pic['url'] as String? ?? '').replaceFirst('http://', 'https://'),
        )
        .toList();

    return ProductDetailsModel(
      id: json['id'] ?? '',
      title: json['title'] ?? 'Sem Título',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      pictures: pictureUrls,
    );
  }
}
