import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

class NotionApiService extends GetxService {

  late final dio.Dio api;
  final _duration = 1000;

  @override
  void onInit() {
    super.onInit();

    api = dio.Dio(
      dio.BaseOptions(
        baseUrl: "https://api.notion.com/",
        connectTimeout: _duration,
        receiveTimeout: _duration,
        sendTimeout: _duration,
        responseType: dio.ResponseType.json,
        headers: {
          'Authorization': '',  // 여기에 실제 비밀키를 사용합니다.
          'Content-Type': 'application/json; charset=utf-8',
          'Notion-Version': '2022-06-28',
        },
      ),
    );
  }

  Future<dio.Response?> getPages(String id) async {
    String version = 'v1/';
    String uri = 'databases/$id/query';

    try {
      dio.Response response = await api.post(version + uri);
      print(response.data); // 응답 데이터 출력
      return response;
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }
}
