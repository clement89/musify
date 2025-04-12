import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:musify_app/modules/cart/domain/entities/cart.dart';
import 'package:musify_app/modules/cart/domain/usecases/cart_usecases.dart';
import 'package:musify_app/modules/songs/domain/entities/song.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartUsecases cartUsecases;
  CartBloc({required this.cartUsecases}) : super(CartState.initial()) {
    on<LoadCart>(_loadCart);
    on<AddToCart>(_addToCart);
    on<RemoveFromCart>(_removeFromCart);
  }

  void _loadCart(LoadCart event, Emitter<CartState> emit) {
    // Load the cart from a data source (e.g., local storage, API)
    // For now, we'll just use the initial state
    emit(state.copyWith(cart: state.cart));
  }

  void _addToCart(AddToCart event, Emitter<CartState> emit) {
    final updatedCart = state.cart.copyWith(
      items: List.from(state.cart.items)..add(event.song),
    );
    emit(state.copyWith(cart: updatedCart));
  }

  void _removeFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final updatedCart = state.cart.copyWith(
      items: List.from(state.cart.items)..remove(event.song),
    );
    emit(state.copyWith(cart: updatedCart));
  }
}
