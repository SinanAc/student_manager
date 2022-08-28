import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_data/model/data_model.dart';
import 'package:student_data/provider/update_provider.dart';

class ImagePro extends StatelessWidget {
  final String image;
  final StudentModel data;
  const ImagePro({
    Key? key,
    required this.image,
    required this.data,
  }) : super(key: key);
  @override
  Widget build(context) {
    return Center(
          child : Consumer<UpdateProvider>(builder: (ctx, value, _) {
              return CircleAvatar(
                radius: 50,
                backgroundImage: MemoryImage(const Base64Decoder().convert(
                  value.image,
                )),
              );
            }),
    );
  }
}
