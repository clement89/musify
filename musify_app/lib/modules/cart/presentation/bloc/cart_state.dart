part of 'cart_bloc.dart';

@immutable
class CartState extends Equatable {
  final Cart cart;
  const CartState({required this.cart});

  @override
  List<Object> get props => [cart];

  factory CartState.initial() {
    return const CartState(cart: Cart(items: []));
  }

  CartState copyWith({
    Cart? cart,
  }) {
    return CartState(
      cart: cart ?? this.cart,
    );
  }
}
