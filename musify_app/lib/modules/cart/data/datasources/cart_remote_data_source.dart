import 'package:musify_app/modules/cart/data/datasources/cart_data_source.dart';
import 'package:musify_app/modules/cart/data/models/cart_model.dart';

class CartRemoteDataSource implements CartDataSource {
  @override
  Future<CartModel> fetchCartItems() {
    // TODO: implement fetchCartItems
    throw UnimplementedError();
  }

  @override
  void updatedCart({required CartModel cartModel}) {
    // TODO: implement updatedCart
  }
}
