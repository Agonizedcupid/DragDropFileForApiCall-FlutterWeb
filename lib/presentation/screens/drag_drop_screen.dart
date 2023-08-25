import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

import '../resource/color/colors.dart';

class DragDropScreen extends StatefulWidget {
  const DragDropScreen({Key? key}) : super(key: key);

  @override
  State<DragDropScreen> createState() => _DragDropScreenState();
}

class _DragDropScreenState extends State<DragDropScreen> {


  late DropzoneViewController controller;
  bool isHighlighted = false;
  late String droppedFileName = "Release to drop the files";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          border: Border.all(color: isHighlighted ? mainColor : Colors.transparent, width: 1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Card(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    DropzoneView(
                      onCreated: (ctrl) => controller = ctrl,
                      onLoaded: () => print('Zone loaded'),
                      onError: (ev) => print('Error: $ev'),
                      onHover: () {
                        setState(() {
                          isHighlighted = true;
                        });
                      },
                      onLeave: () {
                        setState(() {
                          isHighlighted = false;
                        });
                      },
                      onDrop: (ev) {
                        print('Dropped file: ${ev.name}');
                        setState(() {
                          isHighlighted = true;
                          droppedFileName = "${ev.name} dropped";
                        });
                      },
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isHighlighted ? const Icon(Icons.water_drop_outlined, size: 50, color: mainColor) :
                          const Icon(Icons.file_present, size: 35, color: mainColor),
                          const SizedBox(height: 10),
                          Text(
                            isHighlighted ? droppedFileName : 'Drop files here',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Convert logic
                },
                child: const Text("Convert"),
              ),

              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
