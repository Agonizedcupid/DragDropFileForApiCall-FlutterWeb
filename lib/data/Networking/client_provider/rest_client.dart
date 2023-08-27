
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doc_to_latex_parser_web/common/constant.dart';
import 'package:retrofit/http.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: universalBaseUrl)
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;


  /// Underlying code is responsible for posting the files to server to get response in [String]
  // @POST("doc-to-latex/toLatex")
  // @MultiPart()
  // Future<String> postFileToConvertInLatex(@Part(name: "doc") File doc);

  //@POST("doc-to-latex/toLatex")
  @POST("toLatex/")
  @MultiPart()
  Future<String> postFileToConvertInLatex(@Part(name: "doc") List<int> docBytes, @Part() String filename);


}