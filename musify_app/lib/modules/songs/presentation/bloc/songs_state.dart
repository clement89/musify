part of 'songs_bloc.dart';

sealed class SongsState extends Equatable {
  const SongsState();
  
  @override
  List<Object> get props => [];
}

final class SongsInitial extends SongsState {}
