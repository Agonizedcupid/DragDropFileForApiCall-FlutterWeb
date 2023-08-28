import 'dart:convert';
import 'package:doc_to_latex_parser_web/presentation/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:http_parser/http_parser.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      //home: const DummyScreen(),
    );
  }
}

class DummyScreen extends StatefulWidget {
  const DummyScreen({super.key});

  @override
  State<DummyScreen> createState() => _DummyScreenState();
}

class _DummyScreenState extends State<DummyScreen> {
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
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          _sendFile();
        },
        child: const Text("dfgsdfgs"),
      ),
    );
  }
}
