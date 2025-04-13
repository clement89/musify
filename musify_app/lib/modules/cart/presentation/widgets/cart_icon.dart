import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart' show Colors, IconButton, Icons;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:musify_app/modules/cart/presentation/bloc/cart_bloc.dart';
import 'package:musify_app/modules/songs/presentation/bloc/songs_bloc.dart';
import 'package:musify_app/routes/app_routes.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return badges.Badge(
          position: badges.BadgePosition.topEnd(top: 0, end: 3),
          badgeContent: Text(
            state.cart.items.length.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          showBadge: state.cart.items.isNotEmpty,
          child: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              context.push(AppRoutes.cartScreen);
            },
          ),
        );
      },
    );
  }
}
