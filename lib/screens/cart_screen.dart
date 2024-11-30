import 'package:flutter/material.dart';
import '../utils/cart.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItems = Cart.getItems();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ Hàng'),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Giỏ hàng trống'))
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final product = cartItems[index];
          return ListTile(
            leading: Image.asset(product.imageUrl, width: 50),
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: const Icon(Icons.remove_shopping_cart),
              onPressed: () {
                Cart.removeFromCart(product); // Xóa sản phẩm khỏi giỏ
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đã xóa khỏi giỏ hàng')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
