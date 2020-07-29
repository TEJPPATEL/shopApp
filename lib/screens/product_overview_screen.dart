import 'package:ShopApp/screens/edit_product_screen.dart';
import 'package:ShopApp/screens/user_product_screen.dart';
import 'package:provider/provider.dart';
import 'package:ShopApp/providers/products.dart';
import 'package:ShopApp/widgets/product_grid.dart';
import 'package:flutter/material.dart';

import 'orders_screen.dart';

enum FilterItem { All, Favourite }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFav = false;
  @override
  Widget build(BuildContext context) {
    final ProductsContainer = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Shop"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => OrderScreen())),
          ),
          PopupMenuButton(
              onSelected: (FilterItem selectedValue) {
                // print(selectedValue);
                setState(() {
                  if (selectedValue == FilterItem.Favourite) {
                    _showFav = true;
                    // print(_showFav);
                  } else {
                    // print("else");
                    _showFav = false;
                    // ProductsContainer.showOnlyFavourite();
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (context) => [
                    PopupMenuItem(
                        child: Text("Show All"), value: FilterItem.All),
                    PopupMenuItem(
                        child: Text(
                          "Favourite Only",
                        ),
                        value: FilterItem.Favourite)
                  ])
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Text(
                  "SHOP APP",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, EditProductScreen.ROUTE_NAME);
              },
              leading: Icon(Icons.edit),
              title: Text("Manage Product"),
            ),
            Divider(
              height: 5,
            ),
             ListTile(
              onTap: () {
                Navigator.pushNamed(context, UserProductScreen.ROUTE_NAME);
              },
              leading: Icon(Icons.edit),
              title: Text("User Product"),
            ),
            // ListTile(
            //   onTap: () {},
            //   leading: Icon(Icons.edit),
            //   title: Text("Manage Product"),
            // ),
          ],
        ),
      ),
      body: ProductGrid(showFavourite: _showFav),
    );
  }
}
