part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

final class LoadCart extends CartEvent {
  const LoadCart();
}

final class AddToCart extends CartEvent {
  final Song song;
  const AddToCart({required this.song});

  @override
  List<Object> get props => [song];
}

final class RemoveFromCart extends CartEvent {
  final Song song;
  const RemoveFromCart({required this.song});

  @override
  List<Object> get props => [song];
}
