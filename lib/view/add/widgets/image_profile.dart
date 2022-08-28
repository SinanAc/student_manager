import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_data/provider/add_provider.dart';

class ImageProfile extends StatelessWidget {
  const ImageProfile({Key? key,}) : super(key: key);
  @override
  Widget build(context) {
    return Center(
      child: Stack(
        children: [
          Consumer<AddProvider>(
              builder: (ctx, value, Widget? child) {
            return CircleAvatar(
              radius: 50,
              backgroundImage: MemoryImage(const Base64Decoder().convert(
              value.image,
              )),
              backgroundColor: Colors.grey,
            );
          }),
          const Positioned(
            bottom: 40,
            right: 40,
            child: Icon(
              Icons.camera_alt,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
