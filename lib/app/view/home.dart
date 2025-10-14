import 'package:flutter/material.dart';
import 'package:flutter_advanced_2025/app/supplemental/asymmetric_view.dart';
import 'package:intl/intl.dart';

import '../model/product.dart';
import '../model/products_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);

    if (products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return products.map((product) {
      return Card(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        product.name,
                        style: theme.textTheme.bodyLarge,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        formatter.format(product.price),
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AsymmetricView(
      products: ProductsRepository.loadProducts(Category.all)
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     leading: IconButton(
    //       icon: const Icon(
    //         Icons.menu,
    //         semanticLabel: 'menu',
    //       ),
    //       onPressed: () {},
    //     ),
    //     title: const Text('SHRINE'),
    //     actions: <Widget>[
    //       IconButton(
    //         icon: const Icon(
    //           Icons.search,
    //           semanticLabel: 'search',
    //         ),
    //         onPressed: () {},
    //       ),
    //       IconButton(
    //         icon: const Icon(
    //           Icons.tune,
    //           semanticLabel: 'filter',
    //         ),
    //         onPressed: () {},
    //       ),
    //     ],
    //   ),
    //   body: AsymmetricView(
    //     products: ProductsRepository.loadProducts(Category.all)
    //     ),
    //   // body: GridView.count(
    //   //   crossAxisCount: 2,
    //   //   padding: const EdgeInsets.all(16.0),
    //   //   childAspectRatio: 8.0 / 9.0,
    //   //   children: _buildGridCards(context),
    //   // ),
    //   resizeToAvoidBottomInset: false,
    // );
  }
}
