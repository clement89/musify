import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:musify_app/core/extentions/buildcontect_extention.dart';
import 'package:musify_app/modules/cart/presentation/bloc/cart_bloc.dart';
import 'package:musify_app/modules/songs/domain/entities/song.dart';
import 'package:musify_app/modules/songs/presentation/bloc/songs_bloc.dart';
import 'package:musify_app/routes/app_routes.dart';

class SongTile extends StatelessWidget {
  final Song song;
  const SongTile({
    super.key,
    required this.song,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customTheme;

    return BlocBuilder<SongsBloc, SongsState>(
      builder: (context, state) {
        final isPlaying =
            state.status == Status.playing && state.currentSong == song;
        final isInCart = state.cart.contains(song); // Check if in cart

        return ListTile(
          onTap: () {
            context.read<SongsBloc>().add(SelectSong(song));
            context.push(AppRoutes.songDetailsScreen);
          },
          leading: Image.network(
            song.albumUrl,
            width: 50.w,
            height: 50.h,
            fit: BoxFit.cover,
          ),
          title: Text(
            song.title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: colors.textColor,
            ),
          ),
          subtitle: Text(
            song.artist,
            style: TextStyle(fontSize: 14.sp),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Play/Pause Button
              IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: () {
                  context.read<SongsBloc>().add(PlaySong(song));
                },
              ),

              // Cart Button (+ to add, - to remove)
              IconButton(
                icon: Icon(isInCart ? Icons.remove : Icons.add),
                onPressed: () {
                  context.read<CartBloc>().add(AddToCart(song: song));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
