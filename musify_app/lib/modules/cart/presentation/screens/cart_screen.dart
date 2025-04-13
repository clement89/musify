import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:musify_app/core/exceptions/app_exception.dart';
import 'package:musify_app/core/extentions/buildcontect_extention.dart';
import 'package:musify_app/core/theme/app_text_style.dart';
import 'package:musify_app/modules/songs/domain/entities/song.dart';
import 'package:musify_app/modules/songs/presentation/bloc/songs_bloc.dart';
import 'package:musify_app/modules/songs/presentation/widgets/cart_summery.dart';
import 'package:musify_app/modules/songs/presentation/widgets/song_tile.dart';
import 'package:musify_app/routes/app_routes.dart';
import 'package:musify_app/widgets/buttons/bouncing_button.dart';
import 'package:musify_app/widgets/snackbar/app_flash.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final colors = context.customTheme;
    final localization = context.loc;

    return BlocListener<SongsBloc, SongsState>(
      listener: (context, state) {
        if (state.status == Status.error) {
          AppFlash.show(
            context: context,
            message: AppException.getCoreErrorMessage(
              context,
              state.error?.code,
            ),
            type: FlashType.error,
          );
        }
      },
      child: BlocBuilder<SongsBloc, SongsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                localization.cart,
                style: AppTextStyles.kTitle.copyWith(color: colors.textColor),
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BouncingButton(
                    onPressed: () {
                      showDialog<bool>(
                        context: context,
                        builder: (context) => CartSummary(
                            cart: context.read<SongsBloc>().state.cart),
                      );
                    },
                    title: localization.checkout,
                  ),
                ],
              ),
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Expanded(
                      child: state.status == Status.progress
                          ? const Center(child: CircularProgressIndicator())
                          : state.cart.isNotEmpty
                              ? ListView.separated(
                                  itemCount: state.cart.length,
                                  separatorBuilder: (_, __) => const Divider(),
                                  itemBuilder: (context, index) {
                                    final Song song = state.cart[index];
                                    return SongTile(song: song);
                                  },
                                )
                              : Center(
                                  child: Text(
                                    localization.noSongsFound,
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
