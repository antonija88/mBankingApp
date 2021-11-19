import 'package:dio/dio.dart';

class HTTPServices {
  final Dio dio = Dio();
  String _baseUrl = "http://mportal.asseco-see.hr";

  Future<Response?> get(String path) async {
    try {
      String _url = '$_baseUrl$path';
      return await dio.get(_url);
    } on DioError catch (e) {
      print(e);
    }
  }
}
