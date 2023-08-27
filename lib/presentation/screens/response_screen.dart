import 'package:doc_to_latex_parser_web/domain/view_models/file_post_notifier.dart';
import 'package:doc_to_latex_parser_web/presentation/screens/drag_drop_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResponseScreen extends ConsumerStatefulWidget {
  const ResponseScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ResponseScreen> createState() => _ResponseScreenState();
}

class _ResponseScreenState extends ConsumerState<ResponseScreen> {
  @override
  Widget build(BuildContext context) {


    if (globalDroppedFile != null && globalFileName != null) {
      final observeResponse = ref.watch(filePostNotifierProvider(ContentParam(list: globalDroppedFile!, fileName: globalFileName!)));


      return Container(
        margin: const EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        color: Colors.white,
        child: Card(
          child: Container(
            padding: const EdgeInsets.only(
                left: 15, right: 15, top: 10, bottom: 10),
            child: SingleChildScrollView(
              child: observeResponse != null
                  ? observeResponse.when(
                  data: (response) {
                    return Text("$response");
                  },
                  error: (errorMessage, stackTrace) {
                    return Center(child: Text(errorMessage.toString()),);
                  },
                  loading: () {
                    return const Center(child: CircularProgressIndicator());
                  }
              )
                  : const Center(child: Text("Drop a file first")),
            ),
          ),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        color: Colors.white,
        child: Card(
          child: Container(
            padding: const EdgeInsets.only(
                left: 15, right: 15, top: 10, bottom: 10),
            child: const Center(child: Text("Preparing ....... ")),
          ),
        ),
      );
    }


  }
}
