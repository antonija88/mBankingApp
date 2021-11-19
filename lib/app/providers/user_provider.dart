import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mbanking_app/app/models/user.dart';
part 'user_provider.freezed.dart';

@freezed
abstract class UserState with _$UserState {
  const factory UserState({
    @Default(null) User? user,
    @Default(false) bool isLoading,
  }) = _UserState;
}

final userProvider = StateNotifierProvider((ref) => UserNotifier());

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(UserState());

  void saveUser(User newUser) {
    state = state.copyWith(user: newUser);
  }

  void savePin(int pin) {
    state.user!.pin = pin;
    state = state.copyWith(user: state.user);
  }
}
