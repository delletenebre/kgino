import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_state.dart';

part 'player_controller.freezed.dart';

class PlayerController extends Cubit<PlayerState> {

  PlayerController() : super(const PlayerState.initial()) {
    
  }

}
