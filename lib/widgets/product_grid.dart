// import 'package:ShopApp/providers/product.dart';
import 'package:ShopApp/providers/products.dart';
import 'package:ShopApp/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavourite;
  ProductGrid({this.showFavourite});

  @override
  Widget build(BuildContext context) {
    // print("showfavourite");
    print(showFavourite);
    final productData = Provider.of<Products>(context);
    final products =
        showFavourite ? productData.favouriteItems : productData.items;
    // final products = showFavourite ? productData.showOnlyFavouriteProduct : productData.showOnlyFavouriteProduct;

    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
              // create: (context) => products[index] , // alternative way approach to create
              value: products[index],
              child: ProductItem(
                  // id: products[index].id,
                  // title: products[index].title,
                  // imageUrl: products[index].imageUrl,
                  ),
            ),
        itemCount: products.length);
}
}
