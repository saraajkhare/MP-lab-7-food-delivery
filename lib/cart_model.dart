import 'package:flutter/foundation.dart';

class CartItem {
  final String title;
  final String subtitle;
  final String image;
  final double price;
  int quantity;

  CartItem({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.price,
    this.quantity = 1,
  });
}

class CartModel {
  static final ValueNotifier<List<CartItem>> cartItemsNotifier =
      ValueNotifier<List<CartItem>>([]);

  static void addItem(CartItem newItem) {
    final existingIndex = cartItemsNotifier.value.indexWhere(
      (item) => item.title == newItem.title,
    );

    if (existingIndex != -1) {
      // Item already in cart → increase quantity
      cartItemsNotifier.value[existingIndex].quantity += 1;
    } else {
      cartItemsNotifier.value.add(newItem);
    }

    cartItemsNotifier.notifyListeners();
  }

  static void removeItem(CartItem item) {
    cartItemsNotifier.value.remove(item);
    cartItemsNotifier.notifyListeners();
  }

  static void updateQuantity(CartItem item, int change) {
    final index = cartItemsNotifier.value.indexOf(item);
    if (index != -1) {
      cartItemsNotifier.value[index].quantity += change;
      if (cartItemsNotifier.value[index].quantity <= 0) {
        cartItemsNotifier.value.removeAt(index);
      }
      cartItemsNotifier.notifyListeners();
    }
  }

  static void clearCart() {
    cartItemsNotifier.value.clear();
    cartItemsNotifier.notifyListeners();
  }
}
