import 'package:musify_app/modules/songs/domain/entities/song.dart';

class Cart {
  final List<Song> items;
  const Cart({
    required this.items,
  });
  Cart copyWith({
    List<Song>? items,
  }) {
    return Cart(
      items: items ?? this.items,
    );
  }
}
