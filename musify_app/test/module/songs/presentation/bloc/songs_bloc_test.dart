import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:musify_app/core/exceptions/app_exception.dart';
import 'package:musify_app/modules/songs/domain/entities/feed.dart';
import 'package:musify_app/modules/songs/domain/entities/song.dart';
import 'package:musify_app/modules/songs/domain/usecases/songs_usecase.dart';
import 'package:musify_app/modules/songs/presentation/bloc/songs_bloc.dart';
import 'package:musify_app/routes/app_routes.dart';
import 'package:musify_app/services/navigation/navigation_service.dart';

class MockSongsUseCase extends Mock implements SongsUseCase {}

class MockNavigationService extends Mock implements NavigationService {}

void main() {
  late SongsBloc songsBloc;
  late MockSongsUseCase mockSongsUseCase;
  late MockNavigationService mockNavigationService;

  setUp(() {
    mockSongsUseCase = MockSongsUseCase();
    mockNavigationService = MockNavigationService();
    songsBloc = SongsBloc(
      useCase: mockSongsUseCase,
      navigationService: mockNavigationService,
    );
  });

  tearDown(() {
    songsBloc.close();
  });

  const mockSong = Song(
    id: '1',
    title: 'Test Song',
    artist: 'Test Artist',
    album: 'Test Album',
    albumUrl: 'https://test.com/album.jpg',
    songUrl: 'https://test.com/song.mp3',
    previewUrl: 'https://test.com/preview.mp3',
    category: 'Pop',
    releaseDate: '2025-01-01',
    price: '\$1.29',
    rights: 'All Rights Reserved',
  );

  const mockFeed = Feed(songs: [mockSong]);

  group('SongsBloc', () {
    blocTest<SongsBloc, SongsState>(
      'emits [progress, loaded] when FetchSongs is successful',
      build: () {
        when(() => mockSongsUseCase.fetchFeedsFromRepo())
            .thenAnswer((_) async => mockFeed);
        return songsBloc;
      },
      act: (bloc) => bloc.add(const FetchSongs()),
      expect: () => [
        SongsState.initial().copyWith(status: Status.progress),
        SongsState.initial().copyWith(status: Status.loaded, feed: mockFeed),
      ],
    );

    blocTest<SongsBloc, SongsState>(
      'emits [progress, error] when FetchSongs fails',
      build: () {
        when(() => mockSongsUseCase.fetchFeedsFromRepo())
            .thenThrow(AppException.unexpected);
        return songsBloc;
      },
      act: (bloc) => bloc.add(const FetchSongs()),
      expect: () => [
        SongsState.initial().copyWith(status: Status.progress),
        SongsState.initial()
            .copyWith(status: Status.error, error: AppException.unexpected),
      ],
    );

    blocTest<SongsBloc, SongsState>(
      'emits [playing] when PlaySong is called',
      build: () {
        when(() => mockSongsUseCase.playSong(mockSong))
            .thenAnswer((_) async {});
        return songsBloc;
      },
      act: (bloc) => bloc.add(const PlaySong(mockSong)),
      expect: () => [
        SongsState.initial()
            .copyWith(status: Status.playing, currentSong: mockSong),
      ],
    );

    blocTest<SongsBloc, SongsState>(
      'emits [paused] when PlaySong is called while playing',
      build: () {
        when(() => mockSongsUseCase.pauseSong()).thenAnswer((_) async {});
        return songsBloc;
      },
      seed: () => SongsState.initial().copyWith(
        status: Status.playing,
        currentSong: mockSong,
      ),
      act: (bloc) => bloc.add(const PlaySong(mockSong)),
      expect: () => [
        SongsState.initial().copyWith(status: Status.paused),
      ],
    );

    blocTest<SongsBloc, SongsState>(
      'emits updated state when SelectSong is called',
      build: () => songsBloc,
      act: (bloc) => bloc.add(const SelectSong(mockSong)),
      expect: () => [
        SongsState.initial().copyWith(selectedSong: mockSong),
      ],
      verify: (_) {
        verify(() => mockNavigationService
            .navigateToNamed(AppRoutes.songDetailsScreen)).called(1);
      },
    );

    blocTest<SongsBloc, SongsState>(
      'adds song to cart when AddToCart is called',
      build: () => songsBloc,
      act: (bloc) => bloc.add(const AddToCart(mockSong)),
      expect: () => [
        SongsState.initial().copyWith(cart: [mockSong]),
      ],
    );

    blocTest<SongsBloc, SongsState>(
      'removes song from cart when AddToCart is called with an existing song',
      build: () => songsBloc,
      seed: () => SongsState.initial().copyWith(cart: [mockSong]),
      act: (bloc) => bloc.add(const AddToCart(mockSong)),
      expect: () => [
        SongsState.initial().copyWith(cart: []),
      ],
    );

    blocTest<SongsBloc, SongsState>(
      'navigates to cart screen when OpenCart is called',
      build: () => songsBloc,
      act: (bloc) => bloc.add(const OpenCart()),
      verify: (_) {
        verify(() =>
                mockNavigationService.navigateToNamed(AppRoutes.cartScreen))
            .called(1);
      },
    );
  });
}
