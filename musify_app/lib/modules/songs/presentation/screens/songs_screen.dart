import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musify_app/core/exceptions/app_exception.dart';
import 'package:musify_app/core/extentions/buildcontect_extention.dart';
import 'package:musify_app/core/theme/app_text_style.dart';
import 'package:musify_app/modules/songs/domain/entities/song.dart';
import 'package:musify_app/modules/songs/presentation/bloc/songs_bloc.dart';
import 'package:musify_app/modules/cart/presentation/widgets/cart_icon.dart';
import 'package:musify_app/modules/songs/presentation/widgets/song_tile.dart';
import 'package:musify_app/widgets/no_data.dart';
import 'package:musify_app/widgets/snackbar/app_flash.dart';

class SongsScreen extends StatefulWidget {
  const SongsScreen({super.key});

  @override
  State<SongsScreen> createState() => _SongsScreenState();
}

class _SongsScreenState extends State<SongsScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

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
                localization.title,
                style: AppTextStyles.kTitle.copyWith(color: colors.textColor),
              ),
              actions: const [
                CartIcon(),
              ],
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<SongsBloc>().add(const RefreshSongs());
                  },
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      Expanded(
                        child: state.status == Status.progress
                            ? const Center(child: CircularProgressIndicator())
                            : (state.status == Status.error &&
                                    state.feed?.songs == null)
                                ? NoDataWidget(
                                    message: AppException.getCoreErrorMessage(
                                      context,
                                      state.error?.code,
                                    ),
                                  )
                                : state.feed?.songs?.isNotEmpty == true
                                    ? ListView.separated(
                                        itemCount: state.feed!.songs!.length,
                                        separatorBuilder: (_, __) =>
                                            const Divider(),
                                        itemBuilder: (context, index) {
                                          final Song song =
                                              state.feed!.songs![index];
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
            ),
          );
        },
      ),
    );
  }
}
