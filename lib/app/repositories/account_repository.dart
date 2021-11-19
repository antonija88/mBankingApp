import 'package:mbanking_app/app/models/account.dart';

abstract class AccountRepository {
  Future<List<Account>> getAccounts();
}
