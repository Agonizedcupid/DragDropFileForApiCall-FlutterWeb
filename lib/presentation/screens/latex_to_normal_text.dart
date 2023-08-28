import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tex/flutter_tex.dart';

import '../../providers/global_providers.dart';

class LatexToNormalTex extends ConsumerStatefulWidget {
  const LatexToNormalTex({super.key});

  @override
  ConsumerState<LatexToNormalTex> createState() => _LatexToNormalTexState();
}

class _LatexToNormalTexState extends ConsumerState<LatexToNormalTex> {
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
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                color: Colors.amber,
                child: const Text(
                  "Readable Text",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: SingleChildScrollView(
                    child: TeXView(
                      child: TeXViewColumn(children: [
                        TeXViewInkWell(
                          id: "id_0",
                          child: TeXViewColumn(children: [
                            TeXViewDocument(
                              observeResponse, // <- Using your response here
                              style: const TeXViewStyle(
                                sizeUnit: TeXViewSizeUnit.pixels,
                                  textAlign: TeXViewTextAlign.center,),
                            ),
                            // Removed hardcoded content for clarity. Add as needed.
                          ]),
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
