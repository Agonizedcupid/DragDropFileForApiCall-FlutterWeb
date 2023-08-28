import 'package:doc_to_latex_parser_web/presentation/resource/color/colors.dart';
import 'package:doc_to_latex_parser_web/presentation/screens/drag_drop_screen.dart';
import 'package:doc_to_latex_parser_web/presentation/screens/response_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Doc to latex converter", style: TextStyle(color: Colors.white, fontSize: 16),),backgroundColor: mainColor,),
      body: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag and Drop Area
          Expanded(
            flex: 2, // Taking 2 parts of available space
            child: DragDropScreen(),
          ),
          // Response Area
          Expanded(
            flex: 5,  // Taking 5 parts of available space
            child: ResponseScreen(),
          ),
        ],
      ),
    );
  }
}

