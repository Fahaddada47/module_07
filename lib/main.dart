import 'package:flutter/material.dart';
import 'cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product List Demo',
      home: ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> _products = [
    Product('Product 1', 10.99),
    Product('Product 2', 19.99),
    Product('Product 3', 8.99),
    Product('Product 4', 15.99),
    Product('Product 5', 12.99),
  ];

  void _goToCartPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        centerTitle: true,


      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_products[index].name),
            subtitle: Text('\$${_products[index].price.toStringAsFixed(2)}'),
            trailing: CounterButton(
              product: _products[index],
              onGoToCartPressed: () => _goToCartPage(context),
            ),
          );

        },
      ),
      
    );
  }
}

class Product {
  final String name;
  final double price;

  int count = 0;

  Product(this.name, this.price);
}

class CounterButton extends StatefulWidget {
  final Product product;
  final VoidCallback onGoToCartPressed;

  CounterButton({required this.product, required this.onGoToCartPressed});

  @override
  _CounterButtonState createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  int _count = 0;

  void _incrementCounter() {
    setState(() {
      _count++;
      if (_count == 5) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Congratulations!"),
              content: Text("You've bought 5 ${widget.product.name}!"),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Counter: $_count"),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: Text('Buy Now'),
            ),
          ],
        ),

      ],
    );
  }}
