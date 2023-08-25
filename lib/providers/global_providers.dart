import 'package:dio/dio.dart';
import 'package:doc_to_latex_parser_web/data/Networking/client_provider/rest_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioInterceptorProvider = Provider<InterceptorsWrapper>(
      (ref) => InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        debugPrint('Request uri: ${options.uri}');
        debugPrint('Request Body: ${options.data}');
        return handler.next(options);
      }, onResponse: (Response response, ResponseInterceptorHandler handler) {
    debugPrint('Response body: ${response.data}');
    return handler.next(response);
  }, onError: (DioError error, ErrorInterceptorHandler handler) {
    debugPrint('DIO ERROR: ${error.message}');
    debugPrint('ERROR TYPE: ${error.type}');
    debugPrintStack(stackTrace: error.stackTrace);
    return handler.next(error);
  }),
);

final dioProvider = Provider<Dio>((ref) {
  final Dio dio = Dio();
  dio.interceptors.add(ref.read(dioInterceptorProvider));
  return dio;
});

final restProvider = Provider<RestClient>((ref) {
  final dio = ref.watch(dioProvider);
  return RestClient(dio);
});