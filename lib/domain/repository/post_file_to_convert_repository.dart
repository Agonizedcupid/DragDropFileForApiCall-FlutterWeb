import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doc_to_latex_parser_web/data/Networking/client_provider/rest_client.dart';
import 'package:doc_to_latex_parser_web/data/Networking/repository/post_file_to_convert_impl.dart';
import 'package:doc_to_latex_parser_web/domain/util/network_response_handler.dart';
import 'package:doc_to_latex_parser_web/providers/global_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postFileToConvertRepositoryProvider = Provider<PostFileToConvertRepository>((ref) {
  return PostFileToConvertRepositoryImpl(ref.watch(restProvider));
});

abstract class PostFileToConvertRepository {
  Future<NetworkResponseHandler<String>> postFile(File docFile);
}
