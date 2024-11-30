import 'package:buoi4/utils/product.dart';

class Cart {
  static final List<Product> _items = [];

  // Thêm sản phẩm vào giỏ hàng
  static void addToCart(Product product) {
    _items.add(product);
  }

  // Lấy danh sách sản phẩm trong giỏ hàng
  static List<Product> getItems() {
    return _items;
  }

  // Xóa sản phẩm khỏi giỏ hàng
  static void removeFromCart(Product product) {
    _items.remove(product);
  }

  // Lấy tổng số sản phẩm trong giỏ hàng
  static int getTotalItems() {
    return _items.length;
  }
}
