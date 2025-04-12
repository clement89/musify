import 'package:musify_app/modules/songs/data/models/song_model.dart';
import 'package:musify_app/modules/songs/domain/entities/song.dart';
import 'package:musify_app/modules/cart/domain/entities/cart.dart';

class CartModel extends Cart {
  const CartModel({
    required super.items,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => SongModel.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((e) {
        if (e is SongModel) {
          return e.toMap();
        }
      }).toList(),
    };
  }

  CartModel copyWith({
    List<Song>? items,
  }) {
    return CartModel(
      items: items ?? this.items,
    );
  }

  factory CartModel.fromEntity(Cart entity) {
    return CartModel(
      items: entity.items,
    );
  }

  Cart toEntity() => Cart(items: items);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartModel &&
          runtimeType == other.runtimeType &&
          items == other.items;

  @override
  int get hashCode => items.hashCode;
}
