part of 'splash_bloc.dart';

@immutable
class SplashState extends Equatable {
  final bool loadComplete;
  const SplashState({required this.loadComplete});

  @override
  List<Object> get props => [loadComplete];

  factory SplashState.initial() {
    return const SplashState(loadComplete: false);
  }
  SplashState copyWith({
    bool? loadComplete,
  }) {
    return SplashState(
      loadComplete: loadComplete ?? this.loadComplete,
    );
  }
}
