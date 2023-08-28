import 'package:doc_to_latex_parser_web/domain/view_models/file_post_notifier.dart';
import 'package:doc_to_latex_parser_web/presentation/screens/drag_drop_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/global_providers.dart';

class ResponseScreen extends ConsumerStatefulWidget {
  const ResponseScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ResponseScreen> createState() => _ResponseScreenState();
}

class _ResponseScreenState extends ConsumerState<ResponseScreen> {
  @override
  Widget build(BuildContext context) {
    final observeResponse = ref.watch(convertedLatexProvider);

    return Container(
      margin: const EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Card(
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: SingleChildScrollView(
            child: SelectableText(
              observeResponse,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
              showCursor: true,
              toolbarOptions: const ToolbarOptions(
                copy: true,
                selectAll: true,
                cut: false,
                paste: false,
              ),
            ),
          ),
        ),
      ),
    );
  }

}
