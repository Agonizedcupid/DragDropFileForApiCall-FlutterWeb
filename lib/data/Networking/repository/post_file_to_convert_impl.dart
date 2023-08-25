import 'dart:io';

import 'package:dio/dio.dart';

import '../../../domain/repository/post_file_to_convert_repository.dart';
import '../../../domain/util/network_response_handler.dart';
import '../client_provider/rest_client.dart';

class PostFileToConvertRepositoryImpl extends PostFileToConvertRepository {

  final RestClient restClient;
  PostFileToConvertRepositoryImpl(this.restClient);

  @override
  Future<NetworkResponseHandler<String>> postFile(File docFile) async {
    try {
      final response = await restClient.postFileToConvertInLatex(docFile);
      return NetworkResponseHandler(
          data: response,
          isSuccess: true,
          errorMessage: null
      );
    } on DioError catch (error) {
      String? errorMessage;
      if (error.response?.statusCode == 404) {
        errorMessage = "Failed: ${error.response?.statusCode}";
      } else {
        errorMessage = "Failed to fetch data";
      }

      return NetworkResponseHandler<String>(
          isSuccess: false,
          data: null,
          errorMessage: errorMessage
      );
    }
  }



}