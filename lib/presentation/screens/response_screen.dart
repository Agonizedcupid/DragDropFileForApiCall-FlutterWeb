import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResponseScreen extends StatefulWidget {
  const ResponseScreen({Key? key}) : super(key: key);

  @override
  State<ResponseScreen> createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child:Card(
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: const SingleChildScrollView(
            child: Text('Response will be shown here'),
          ),
        ),
      ),
    );
  }
}
