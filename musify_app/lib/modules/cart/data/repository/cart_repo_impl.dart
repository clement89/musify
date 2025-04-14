import 'package:musify_app/modules/cart/data/datasources/cart_data_source.dart';
import 'package:musify_app/modules/cart/data/models/cart_model.dart';
import 'package:musify_app/modules/cart/domain/entities/cart.dart';
import 'package:musify_app/modules/cart/domain/repository/cart_repo.dart';

class CartRepoImpl implements CartRepository {
  final CartDataSource _dataSource;

  CartRepoImpl(this._dataSource);

  @override
  Future<CartModel> fetchCartItemsRepo() async {
    try {
      return await _dataSource.fetchCartItems();
    } catch (e) {
      rethrow;
    }
  }

  @override
  void updateCartRepo({required Cart cart}) {
    try {
      _dataSource.updatedCart(cartModel: CartModel.fromEntity(cart));
    } catch (e) {
      rethrow;
    }
  }
}
