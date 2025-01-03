import 'package:care2x/Cart/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final bool inStock;
  final int price;

  ProductItem(this.id, this.title, this.imageUrl, this.inStock, this.price);

  @override
  Widget build(BuildContext context) {
    var cartProvider = context.read<CartProvider>();
    print('printing id: ' + id);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {},
          child: Hero(
            tag: id,
            child: Stack(
              children: [
                FadeInImage(
                  placeholder:
                      AssetImage('assets/images/product-placeholder.jpg'),
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      cartProvider.addItemToCart(id, price, title);
                      Scaffold.of(context).hideCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Added item to cart!',
                          ),
                          duration: Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {
                              cartProvider.decrementItemQuantity(id);
                            },
                          ),
                        ),
                      );
                    },
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: inStock == true
              ? Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Rs.$price",
                      style: TextStyle(
                          color: Colors.white, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "In Stock",
                      style: TextStyle(color: Colors.green, fontSize: 8),
                    ),
                  ],
                )
              : Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Rs.$price",
                      style: TextStyle(
                          color: Colors.white, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "No Stock",
                      style: TextStyle(color: Colors.red, fontSize: 8),
                    ),
                  ],
                ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
