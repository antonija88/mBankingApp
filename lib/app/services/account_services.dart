import 'package:dio/dio.dart';
import 'package:mbanking_app/app/models/account.dart';
import 'package:mbanking_app/app/repositories/account_repository.dart';
import 'http_service.dart';

class AccountServices extends AccountRepository {
  late HTTPServices _httpServices;

  AccountServices() {
    _httpServices = HTTPServices();
  }

  @override
  Future<List<Account>> getAccounts() async {
    Response? response =
        await _httpServices.get("/builds/ISBD_public/Zadatak_1.json");
    if (response!.statusCode == 200) {
      return response.data['acounts']
          .map<Account>((model) => Account.fromJson(model))
          .toList();
    } else {
      throw Exception("Failed to fetch accounts");
    }
  }
}
