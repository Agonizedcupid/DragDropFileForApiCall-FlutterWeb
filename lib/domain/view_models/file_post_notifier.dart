
import 'dart:io';
import 'dart:typed_data';

import 'package:doc_to_latex_parser_web/domain/repository/post_file_to_convert_repository.dart';
import 'package:doc_to_latex_parser_web/domain/util/network_response_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final filePostNotifierProvider = StateNotifierProvider.autoDispose
//   .family<FilePostNotifier, AsyncValue<String>, File>((ref, docFile) {
//     return FilePostNotifier(ref.watch(postFileToConvertRepositoryProvider), docFile);
// });
//
//
// class FilePostNotifier extends StateNotifier<AsyncValue<String>> {
//   final PostFileToConvertRepository repository;
//   final File docFile;
//   String? convertedResponse;
//
//   FilePostNotifier(this.repository, this.docFile) : super(const AsyncValue.loading()) {
//     postFileToConvert();
//   }
//
//   Future<void> postFileToConvert() async{
//     try {
//       state = const AsyncValue.loading();
//       final NetworkResponseHandler response = await repository.postFile(docFile);
//
//       if (response.isSuccess) { // meaning everything is ok
//         state = AsyncValue.data(response.data);
//       } else {
//         state = AsyncValue.error(response.errorMessage.toString(), StackTrace.current);
//       }
//
//     }catch(e) {
//       state = AsyncValue.error(e.toString(), StackTrace.current);
//     }
//   }
// }

class ContentParam{
  late final Uint8List list;
  late final String fileName;
  ContentParam({required this.list, required this.fileName});
}

final filePostNotifierProvider = StateNotifierProvider.autoDispose
    .family<FilePostNotifier, AsyncValue<String>, ContentParam>((ref,contentParams) {
  return FilePostNotifier(ref.watch(postFileToConvertRepositoryProvider), contentParams.list, contentParams.fileName);
});


class FilePostNotifier extends StateNotifier<AsyncValue<String>> {
  final PostFileToConvertRepository repository;
  late final Uint8List list;
  late final String fileName;
  String? convertedResponse;

  FilePostNotifier(this.repository, this.list, this.fileName) : super(const AsyncValue.loading()) {
    postFileToConvert();
  }

  Future<void> postFileToConvert() async {
    try {
      state = const AsyncValue.loading();
      final NetworkResponseHandler response = await repository.postFile(list, fileName);

      if (response.isSuccess) { // meaning everything is ok
        if (mounted) {
          state = AsyncValue.data(response.data);
        } else {
          debugPrint("NOT MOUNTED 1");
        }

      } else {
        if (mounted) {
          state = AsyncValue.error(response.errorMessage.toString(), StackTrace.current);
        } else {
          debugPrint("NOT MOUNTED 2");
        }
      }

    } catch (e) {
      if (mounted) {
        state = AsyncValue.error(e.toString(), StackTrace.current);
      } else {
        debugPrint("NOT MOUNTED 3");

      }

    }
  }
}
