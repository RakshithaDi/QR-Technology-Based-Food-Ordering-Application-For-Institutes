import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:food_ordering_application/model/item.dart';

class Cart extends ChangeNotifier {
  static List<Item> _items = [];
  static int noificationCount = 0;
  static void EmptyCart() {
    _items.removeRange(0, _items.length);
  }

  static double _totalPrice = 0.00;
  void add(Item item) {
    int index = _items.indexWhere((i) => i.name == item.name);
    print('indexxxx $index');
    if (index == -1) {
      _items.add(item);
      _totalPrice += item.price;
      notifyListeners();
      Get.snackbar(
          "Product Added", "You have added the ${item.name} to the cart",
          snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 1));
    } else {
      Get.snackbar("Already Added ",
          "You have added the ${item.name} to the cart already",
          snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 1));
    }
  }

  static void NotificationLength(int value) {
    noificationCount = value;
  }

  static int get NotifyCount {
    return noificationCount;
  }

  void remove(Item item) {
    _totalPrice -= item.price;
    _items.remove(item);
    notifyListeners();
  }

  void calculateTotal() {
    _totalPrice = 0;
    _items.forEach((f) {
      _totalPrice += f.price * f.quantity;
    });
    notifyListeners();
  }

  void updateProduct(item, quantity) {
    int index = _items.indexWhere((i) => i.name == item.name);
    _items[index].quantity = quantity;
    if (_items[index].quantity == 0) remove(item);

    calculateTotal();
    notifyListeners();
  }

  static int get count {
    return _items.length;
  }

  static double get totalPrice {
    return _totalPrice;
  }

  static List<Item> get basketItems {
    return _items;
  }

  static void googlePayStatus() {
    Get.snackbar("PAYMENT SUCCESS!", "Thank You!",
        snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2));
  }

  static void PaymentStates() {
    Get.snackbar("Order Placed Successfully!", "Thank You!",
        snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2));
  }
}
