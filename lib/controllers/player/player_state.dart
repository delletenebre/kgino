part of 'player_controller.dart';

@freezed
class PlayerState with _$PlayerState {
  const factory PlayerState.initial() = _Initial;

  const factory PlayerState.loading() = _Loading;

  const factory PlayerState.error() = _Error;

  const factory PlayerState.play() = _Play;

}
