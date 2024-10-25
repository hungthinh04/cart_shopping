import 'package:baitap/models/product.dart';
import 'package:collection/collection.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  int get totalPrice => product.price * quantity;
}

class Cart {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  // Thêm sản phẩm vào giỏ hàng hoặc tăng số lượng nếu đã có
  void addItem(Product product) {
    CartItem? existingItem = _items.firstWhereOrNull(
  (item) => item.product.name == product.name,
);



    if (existingItem != null) {
      existingItem.quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
  }
 void addItemWithQuantity(Product product, int quantity) {
    CartItem? existingItem = _items.firstWhereOrNull(
        (item) => item.product.name == product.name,
    );

    if (existingItem != null) {
      existingItem.quantity += quantity; // Increase the quantity
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
  }
   void removeItem(CartItem cartItem) {
    _items.remove(cartItem);
  }
  int get totalItems {
    return _items.fold(0, (total, item) => total + item.quantity);
  }

  int get totalPrice {
    return _items.fold(0, (total, item) => total + item.totalPrice);
  }

  // Tăng/giảm số lượng sản phẩm
  void increaseQuantity(CartItem cartItem) {
    cartItem.quantity++;
  }

  void decreaseQuantity(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
    } else {
      _items.remove(cartItem);
    }
  }

  void clearCart() {
    _items.clear();
  }
}
