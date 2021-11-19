import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mbanking_app/app/models/account.dart';
import 'package:mbanking_app/app/services/account_services.dart';
part 'accounts_provider.freezed.dart';

@freezed
abstract class AccountState with _$AccountState {
  const factory AccountState({
    @Default([]) List<Account> accounts,
    @Default(null) Account? account,
    @Default(false) bool isLoading,
  }) = _AccountState;
}

final accountsProvider = StateNotifierProvider((ref) => AccountNotifier());

class AccountNotifier extends StateNotifier<AccountState> {
  AccountNotifier() : super(const AccountState()) {
    getAccounts();
  }

  void getAccounts() async {
    state = state.copyWith(isLoading: true);
    final accounts = await AccountServices().getAccounts();
    accounts[0].isSelected = true;
    final account = accounts[0];
    account.transactions!.sort((a, b) => b.date!.compareTo(a.date!));
    state =
        state.copyWith(isLoading: false, accounts: accounts, account: account);
  }

  void changeAccount(int index) {
    state.accounts.forEach((element) {
      element.isSelected = false;
    });
    state.accounts[index].isSelected = true;
    final account = state.accounts[index];
    account.transactions!.sort((a, b) => b.date!.compareTo(a.date!));
    state = state.copyWith(accounts: state.accounts, account: account);
  }
}
