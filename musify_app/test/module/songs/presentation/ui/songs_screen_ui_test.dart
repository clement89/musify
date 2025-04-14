import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mocktail/mocktail.dart';
import 'package:musify_app/core/exceptions/app_exception.dart';
import 'package:musify_app/core/theme/custom_theme.dart';
import 'package:musify_app/modules/cart/domain/entities/cart.dart';
import 'package:musify_app/modules/cart/presentation/bloc/cart_bloc.dart';
import 'package:musify_app/modules/songs/domain/entities/feed.dart';
import 'package:musify_app/modules/songs/domain/entities/song.dart';
import 'package:musify_app/modules/songs/presentation/bloc/songs_bloc.dart';
import 'package:musify_app/modules/songs/presentation/screens/songs_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

class MockSongsBloc extends Mock implements SongsBloc {}

class FakeSongsEvent extends Fake implements SongsEvent {}

class FakeSongsState extends Fake implements SongsState {}

class MockCartBloc extends Mock implements CartBloc {}

class FakeCartEvent extends Fake implements CartEvent {}

class FakeCartState extends Fake implements CartState {}

// Your imports remain unchanged...

void main() {
  late SongsBloc songsBloc;
  late CartBloc cartBloc;

  setUpAll(() {
    registerFallbackValue(FakeSongsEvent());
    registerFallbackValue(FakeSongsState());
    registerFallbackValue(FakeCartEvent());
    registerFallbackValue(FakeCartState());
  });

  setUp(() {
    songsBloc = MockSongsBloc();
    cartBloc = MockCartBloc();

    when(() => songsBloc.state).thenReturn(SongsState.initial());
    when(() => songsBloc.stream)
        .thenAnswer((_) => const Stream<SongsState>.empty());

    when(() => cartBloc.state)
        .thenReturn(const CartState(cart: Cart(items: [])));
    when(() => cartBloc.stream)
        .thenAnswer((_) => const Stream<CartState>.empty());
  });

  Future<void> pumpTestWidget(WidgetTester tester, Widget child) async {
    await mockNetworkImages(() async {
      await tester.pumpWidget(ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, _) => MultiBlocProvider(
          providers: [
            BlocProvider<SongsBloc>.value(value: songsBloc),
            BlocProvider<CartBloc>.value(value: cartBloc),
          ],
          child: MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            theme: ThemeData.light().copyWith(
              extensions: [CustomTheme.light],
            ),
            home: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0),
              ),
              child: child,
            ),
          ),
        ),
      ));
    });
  }

  group('SongsScreen Widget Tests', () {
    testWidgets('displays CircularProgressIndicator when loading',
        (tester) async {
      when(() => songsBloc.state)
          .thenReturn(SongsState.initial().copyWith(status: Status.progress));
      whenListen(
          songsBloc,
          Stream.fromIterable(
              [SongsState.initial().copyWith(status: Status.progress)]));

      await pumpTestWidget(tester, const SongsScreen());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays songs list when data is available', (tester) async {
      final songs = [
        const Song(
          id: '1802103977',
          title: 'Just In Case',
          artist: 'Morgan Wallen',
          album: 'I’m The Problem',
          albumUrl:
              'https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/1e/ef/26/1eef2600-29f4-5423-3052-26874afd2947/25UMGIM46050.rgb.jpg/170x170bb.png',
          songUrl:
              'https://music.apple.com/us/album/just-in-case/1802103958?i=1802103977&uo=2',
          previewUrl:
              'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview221/v4/3c/70/a0/3c70a0e6-d3a3-600c-b719-4cc32ab2f465/mzaf_8969669218717400451.plus.aac.p.m4a',
          category: 'Country',
          releaseDate: '2025-03-21',
          price: '1.29',
          rights: '℗ 2025 Big Loud Records...',
        ),
        const Song(
          id: '1802104591',
          title: 'I\'m A Little Crazy',
          artist: 'Morgan Wallen',
          album: 'I’m The Problem',
          albumUrl:
              'https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/1e/ef/26/1eef2600-29f4-5423-3052-26874afd2947/25UMGIM46050.rgb.jpg/170x170bb.png',
          songUrl:
              'https://music.apple.com/us/album/im-a-little-crazy/1802103958?i=1802104591&uo=2',
          previewUrl:
              'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview211/v4/92/da/32/92da32e4-1b55-1f0d-abaa-21f7ba9913d8/mzaf_5011318409286053272.plus.aac.p.m4a',
          category: 'Country',
          releaseDate: '2025-03-21',
          price: '1.29',
          rights: '℗ 2025 Big Loud Records...',
        ),
      ];

      final state = SongsState(
        status: Status.loaded,
        feed: Feed(songs: songs),
        error: null,
        currentSong: null,
        selectedSong: null,
      );

      when(() => songsBloc.state).thenReturn(state);
      whenListen(songsBloc, Stream.fromIterable([state]));

      await pumpTestWidget(tester, const SongsScreen());
      await tester.pump();

      expect(find.text('Just In Case'), findsOneWidget);
      expect(find.text("I'm A Little Crazy"), findsOneWidget);
    });

    testWidgets('displays empty message when no songs are available',
        (tester) async {
      const state = SongsState(
        status: Status.loaded,
        feed: Feed(songs: []),
        error: null,
        currentSong: null,
        selectedSong: null,
      );

      when(() => songsBloc.state).thenReturn(state);
      whenListen(songsBloc, Stream.fromIterable([state]));

      await pumpTestWidget(tester, const SongsScreen());
      await tester.pump();

      expect(find.textContaining('no songs found', findRichText: true),
          findsOneWidget);
    });

    testWidgets('triggers RefreshSongs on pull to refresh', (tester) async {
      final songs = [
        const Song(
          id: '1',
          title: 'Hello',
          artist: 'Adele',
          album: '25',
          albumUrl: 'https://example.com/album/25',
          songUrl: 'https://example.com/song/hello',
          previewUrl: 'https://example.com/preview/hello',
          category: 'Pop',
          releaseDate: '2015-10-23',
          price: '1.29',
          rights: '℗ 2015 XL Recordings Ltd.',
        ),
      ];

      final state = SongsState.initial().copyWith(
        status: Status.loaded,
        feed: Feed(songs: songs),
      );

      when(() => songsBloc.state).thenReturn(state);
      whenListen(songsBloc, Stream.fromIterable([state]));

      await pumpTestWidget(tester, const SongsScreen());
      await tester.pump();

      await tester.drag(
          find.byType(RefreshIndicator), const Offset(0.0, 300.0));
      await tester.pumpAndSettle();

      verify(() => songsBloc.add(const RefreshSongs())).called(1);
    });

    testWidgets('shows error flash message when error occurs', (tester) async {
      final state = SongsState.initial().copyWith(
        status: Status.error,
        error: AppException.networkError,
      );

      when(() => songsBloc.state).thenReturn(state);
      whenListen(songsBloc, Stream.fromIterable([state]));

      await pumpTestWidget(tester, const SongsScreen());
      await tester.pump(const Duration(seconds: 1));

      expect(
          find.textContaining('network', findRichText: true), findsOneWidget);
    });
  });
}
