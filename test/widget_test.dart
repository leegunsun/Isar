// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'widget_test.mocks.dart';

class ApiService {
  Dio dio = Dio(BaseOptions(
    connectTimeout: 500,  // 500ms로 연결 타임아웃 설정
    receiveTimeout: 500,  // 500ms로 응답 타임아웃 설정
  ));
  final int maxRetries = 5;

  final Connectivity connectivity;

  ApiService({required this.connectivity});

  Future<void> fetchData(String url) async {
    int retryCount = 0;

    List<ConnectivityResult> connectivityResults = await connectivity.checkConnectivity();

    if (connectivityResults.contains(ConnectivityResult.none)) {
      print('네트워크에 연결되어 있지 않습니다.');
      return;
    }

    while (retryCount < maxRetries) {
      try {
        final response = await dio.get(url);
        print('Success: ${response.data}');
        return; // 성공 시 종료
      } catch (e) {
        if(e is DioError) {
          if (e.type == DioErrorType.connectTimeout && e.error is SocketException) {
            print('서버에 연결할 수 없습니다. 네트워크 문제일 가능성이 큽니다.');
            rethrow;
          } else if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
            print('서버와의 연결이 타임아웃되었습니다. 서버가 응답하지 않거나 연결이 원활하지 않습니다.');
            retryCount++;
            print('Timeout occurred. Attempt: $retryCount');

            if (retryCount == maxRetries) {
              print('Timeout 5회 이상 발생');
              rethrow; // 에러를 다시 던짐
            }
          } else {
            print('Error: ${e.message}');
            rethrow; // 에러를 다시 던짐
          }
        } else {
          rethrow;
        }
      }
    }
  }
}

@GenerateMocks([Dio, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // 바인딩 초기화

  group("APi 태스트", () {
    late MockDio mockDio;
    late MockConnectivity mockConnectivity;
    late ApiService apiService;

    setUp(() {
      mockDio = MockDio();
      mockConnectivity = MockConnectivity();
      apiService = ApiService(connectivity: mockConnectivity)..dio = mockDio;
    });

    test('Should retry up to maxRetries times on timeout', () async {
      when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.mobile]);
      when(mockDio.get(any)).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: ''),
          type: DioErrorType.connectTimeout,
          error: SocketException('Failed to connect'),
        ),
      );

      try {
        await apiService.fetchData('https://api.example.com/data');
      } catch (e) {
        expect(e, isA<DioError>());
      }

      verify(mockDio.get(any)).called(1);
    });

    test('Should throw error after maxRetries exceeded', () async {
      when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.mobile]);
      when(mockDio.get(any)).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: ''),
          type: DioErrorType.connectTimeout,
        ),
      );

      try {
        await apiService.fetchData('https://api.example.com/data');
        fail('Should have thrown a DioError');  // 이 줄은 예외가 발생하지 않으면 테스트를 실패시키기 위해 추가합니다.
      } catch (e) {
        expect(e, isA<DioError>());
      }

      verify(mockDio.get(any)).called(apiService.maxRetries);
    });


    test('Should not attempt request when network is disconnected', () async {
      when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.none]);

      await apiService.fetchData('https://api.example.com/data');

      verifyNever(mockDio.get(any));
    });

    test('Should return successfully when API call is successful', () async {
      // Mocking Connectivity to simulate an active network connection
      when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.mobile]);

      // Mocking Dio to return a successful response
      when(mockDio.get(any)).thenAnswer((_) async => Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: 'Success response data',
      ));

      // Run the fetchData method
      await apiService.fetchData('https://api.example.com/data');

      // Verify that Dio's get method was called exactly once
      verify(mockDio.get(any)).called(1);

      // Optionally, you can add additional assertions to verify the expected behavior
    });

  });
}
