import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/view_models/file_post_notifier.dart';
import '../resource/color/colors.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          border: Border.all(
              color: isHighlighted ? mainColor : Colors.transparent, width: 1),
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
                      onDrop: (ev) async {
                        var data = await controller.getFileData(ev);
                        setState(() {
                          isHighlighted = true;
                          droppedFileName = "${ev.name} dropped";
                          globalDroppedFile = data;
                          globalFileName = ev.name;
                        });

                        if (globalDroppedFile != null && globalFileName != null) {
                          ref.read(filePostNotifierProvider(ContentParam(list: globalDroppedFile!, fileName: globalFileName!)));
                        } else {
                          // Handle the error or show a message to the user.
                        }
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
              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}

