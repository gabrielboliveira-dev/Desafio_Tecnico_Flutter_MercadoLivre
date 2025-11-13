import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/product_details_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productId;

  const ProductDetailsPage({Key? key, required this.productId})
    : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductDetailsProvider>().fetchProductDetails(
        widget.productId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final priceFormatter = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Produto'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black87,
      ),
      body: Consumer<ProductDetailsProvider>(
        builder: (context, provider, child) {
          switch (provider.state) {
            case DetailsState.loading:
              return const Center(child: CircularProgressIndicator());
            case DetailsState.error:
              return Center(child: Text(provider.errorMessage));
            case DetailsState.success:
              if (provider.productDetails == null) {
                return const Center(child: Text('Produto não encontrado.'));
              }

              final product = provider.productDetails!;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 300,
                      child: PageView.builder(
                        itemCount: product.pictures.length,
                        itemBuilder: (context, index) {
                          return CachedNetworkImage(
                            imageUrl: product.pictures[index],
                            fit: BoxFit.contain,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          );
                        },
                      ),
                    ),
                    const Divider(),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            priceFormatter.format(product.price),
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            case DetailsState.initial:
            default:
              return const SizedBox.shrink(); // Não mostra nada
          }
        },
      ),
    );
  }
}
