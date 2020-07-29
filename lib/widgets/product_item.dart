import 'package:ShopApp/providers/cart.dart';
import 'package:ShopApp/providers/product.dart';
import 'package:ShopApp/screens/orders_screen.dart';

import 'package:ShopApp/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem({this.id, this.title, this.imageUrl});

  // void _selectedProduct(BuildContext context, String id, String title) {
  //   Navigator.pushNamed(context, ProductDetailScreen.ROUTE_NAME,
  //       arguments: {"id": id, "title": title});
  // }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    print("product called");
    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductDetailScreen.ROUTE_NAME,
          arguments: {"id": product.id, "title": product.title}),
      // onTap: () => _selectedProduct(context, id, title),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              leading: Consumer<Product>(
                builder: (context, product, child) => IconButton(
                  icon: Icon(
                      product.isFavourite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Theme.of(context).accentColor),
                  onPressed: () {
                    product.toggleFavourite();
                  },
                ),
              ),
              title: Text(product.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              trailing: IconButton(
                  icon: Consumer<Cart>(
                    builder: (context, cart, Widget child) => Icon(
                        Icons.shopping_cart,
                        color: Theme.of(context).accentColor),
                  ),
                  onPressed: () {
                    cart.addItem(product.id, product.title, product.price);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Item Added into cart"),
                      duration: Duration(seconds: 2),
                      action: SnackBarAction(label: "Undo", onPressed: () {
                        cart.removeSingleItem(product.id);
                      },)
                    ));
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
