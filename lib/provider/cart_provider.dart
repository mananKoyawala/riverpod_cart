import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/products.dart';
part 'cart_provider.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
  bool sorted = false;

  // initial value
  @override
  Set<Product> build() {
    return const {};
  }

  // methods to update state
  void addProduct(Product product) {
    if (!state.contains(product)) {
      state = {...state, product};
      sortByPriceASC();
    }
  }

  void removeProduct(Product product) {
    if (state.contains(product)) {
      // remove product
      final products = state.toList();
      products.remove(product);
      state = products.toSet();
    }
  }

  void sortByPriceASC() {
    final products = state.toList();
    products.sort((a, b) => a.price.compareTo(b.price));
    state = products.toSet();
  }

  void sortByPriceDESC() {
    final products = state.toList();
    products.sort((a, b) => b.price.compareTo(a.price));
    state = products.toSet();
  }

  void changeProductDESC(bool val) {
    sorted = val;
  }
}

// return total price of cart products
@riverpod
int cartTotal(ref) {
  final products = ref.watch(cartNotifierProvider);
  int total = 0;

  for (Product product in products) {
    total += product.price;
  }

  return total;
}



// * without provider generator

// class CartNotifier extends Notifier<Set<Product>> {
//   bool sorted = false;

//   // initial value
//   @override
//   Set<Product> build() {
//     return const {
//       Product(
//           id: '4',
//           title: 'Red Backpack',
//           price: 14,
//           image: 'assets/products/backpack.png'),
//     };
//   }

//   // methods to update state
//   void addProduct(Product product) {
//     if (!state.contains(product)) {
//       state = {...state, product};
//       sortByPriceASC();
//     }
//   }

//   void removeProduct(Product product) {
//     if (state.contains(product)) {
//       // remove product
//       final products = state.toList();
//       products.remove(product);
//       state = products.toSet();
//     }
//   }

//   void sortByPriceASC() {
//     final products = state.toList();
//     products.sort((a, b) => a.price.compareTo(b.price));
//     state = products.toSet();
//   }

//   void sortByPriceDESC() {
//     final products = state.toList();
//     products.sort((a, b) => b.price.compareTo(a.price));
//     state = products.toSet();
//   }

//   void changeProductDESC(bool val) {
//     sorted = val;
//   }
// }

// final cartNotifierProvider = NotifierProvider<CartNotifier, Set<Product>>(() {
//   return CartNotifier();
// });
