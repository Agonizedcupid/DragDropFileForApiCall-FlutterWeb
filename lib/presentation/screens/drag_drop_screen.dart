import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/view_models/file_post_notifier.dart';
import '../../providers/global_providers.dart';
import '../resource/color/colors.dart';

import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:http_parser/http_parser.dart';

Uint8List? globalDroppedFile;
String? globalFileName;

class DragDropScreen extends ConsumerStatefulWidget {
  const DragDropScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DragDropScreen> createState() => _DragDropScreenState();
}

class _DragDropScreenState extends ConsumerState<DragDropScreen> {
  late DropzoneViewController controller;
  bool isHighlighted = false;
  late String droppedFileName = "Release to drop the files";

  void _sendFile() async {
    final fileInput = html.FileUploadInputElement();
    fileInput.click();

    fileInput.onChange.listen((e) async {
      final files = fileInput.files;
      if (files!.length == 1) {
        final file = files[0];
        final reader = html.FileReader();

        reader.onLoadEnd.listen((e) {
          _uploadFile(reader.result as String, file.name);
        });


        reader.readAsDataUrl(file);
      }
    });
  }

  Future<void> _uploadFile(String dataUrl, String fileName) async {
    // Extract the base64 data from the data URL
    final rawBase64String = dataUrl.split(',').last;
    final bytes = base64Decode(rawBase64String);

    //var uri = Uri.parse('http://localhost:8080/toLatex');
    var uri = Uri.parse('https://app.utkorsho.org/api/doc-to-latex/toLatex');

    var request = http.MultipartRequest('POST', uri)
      ..files.add(http.MultipartFile.fromBytes(
          'doc',
          bytes,
          filename: fileName,
          contentType: MediaType('application', 'vnd.openxmlformats-officedocument.wordprocessingml.document')
      ));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Uploaded!');
        // Consider using a Snackbar or dialog to show this to the user
        // Get the response body and print it
        var responseBody = await response.stream.bytesToString();
        print('Response from server: $responseBody');
        ref.read(convertedLatexProvider.notifier).updateResponse(responseInString: responseBody);
      } else {
        print('Failed to upload file. Status code: ${response.statusCode}');
        // Show error message to user
      }
    } catch (error) {
      print('Error occurred: $error');
      // Handle error and maybe inform the user
    }
  }


  @override
  Widget build(BuildContext context) {
    // return Container(
    //   margin: const EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
    //   child: AnimatedContainer(
    //     duration: const Duration(milliseconds: 150),
    //     decoration: BoxDecoration(
    //       border: Border.all(
    //           color: isHighlighted ? mainColor : Colors.transparent, width: 1),
    //       borderRadius: BorderRadius.circular(8.0),
    //     ),
    //     child: Card(
    //
    //       child: Container(
    //         height: MediaQuery.of(context).size.height,
    //         child: SizedBox(
    //           height: 50,
    //           width: 100,
    //           child: ElevatedButton(onPressed: () {
    //             _sendFile();
    //           }, child: const Text("Upload File")),
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    return Container(
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: Border.all(
            color: isHighlighted ? mainColor : Colors.transparent, width: 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: SizedBox(
            height: 50,
            width: 250,
            child: ElevatedButton(
              onPressed: _sendFile,
              child: const Text("Upload File"),
            ),
          ),
        ),
      ),
    );
  }
}
