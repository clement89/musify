import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musify_app/core/extentions/buildcontect_extention.dart';
import 'package:musify_app/core/theme/app_text_style.dart';
import 'package:musify_app/modules/cart/presentation/bloc/cart_bloc.dart';
import 'package:musify_app/modules/songs/domain/entities/song.dart';

class CartSummary extends StatelessWidget {
  final List<Song> cart;

  const CartSummary({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    final colors = context.customTheme;
    return AlertDialog(
      title: Text(
        context.loc.cartSummery,
        style: AppTextStyles.kTitle.copyWith(color: colors.textColor),
      ),
      content: cart.isEmpty
          ? Text(
              context.loc.noItemsFound,
              style: AppTextStyles.kSubTitle.copyWith(color: colors.textColor),
            )
          : SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(cart[index].title),
                  );
                },
              ),
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.loc.cancel),
        ),
        if (cart.isNotEmpty)
          TextButton(
            onPressed: () {
              context.read<CartBloc>().add(const ClearCart());
              Navigator.pop(context, true);
            },
            child: Text(context.loc.done),
          ),
      ],
    );
  }
}
