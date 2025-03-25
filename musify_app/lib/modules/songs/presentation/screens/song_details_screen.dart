import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musify_app/core/theme/app_text_style.dart';
import 'package:musify_app/modules/songs/presentation/bloc/songs_bloc.dart';
import 'package:musify_app/core/extentions/buildcontect_extention.dart';

class SongDetailsScreen extends StatelessWidget {
  const SongDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.customTheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<SongsBloc, SongsState>(
      builder: (context, state) {
        if (state.selectedSong == null) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final song = state.selectedSong!;
        final isPlaying =
            state.status == Status.playing && state.currentSong == song;

        return Scaffold(
          appBar: AppBar(
              title: Text(
            song.title,
            style: AppTextStyles.kTitle.copyWith(
              color: colors.textColor,
            ),
          )),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Album Cover
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(song.albumUrl,
                        width: 200, height: 200, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 20),

                  // Song Title
                  Text(
                    song.title,
                    style: AppTextStyles.kSubTitle
                        .copyWith(color: colors.textColor),
                  ),
                  const SizedBox(height: 8),

                  // Artist Name
                  Text(song.artist, style: textTheme.bodyMedium),
                  const SizedBox(height: 8),

                  // Album Name
                  if (song.album.isNotEmpty)
                    Text("Album: ${song.album}", style: textTheme.bodySmall),
                  const SizedBox(height: 20),

                  // Audio Progress Bar (visible only when playing)

                  // Play/Pause Button
                  BlocBuilder<SongsBloc, SongsState>(
                    buildWhen: (previous, current) =>
                        previous.currentSong != current.currentSong ||
                        previous.status != current.status,
                    builder: (context, state) {
                      final isPlaying = state.status == Status.playing &&
                          state.currentSong == state.selectedSong!;

                      return IconButton(
                        iconSize: 64,
                        icon: Icon(
                          isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_filled,
                        ),
                        onPressed: () {
                          context.read<SongsBloc>().add(PlaySong(song));
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
