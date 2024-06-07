import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class FullScreenImage extends StatelessWidget {
  const FullScreenImage({super.key});

  @override
  Widget build(BuildContext context) {
    final pickedImagePath = Get.arguments['pickedImagePath'] as String;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(left: 15),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.arrowLeft,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          )),
      backgroundColor: Colors.black,
      body: Center(
        child: Hero(
          tag: pickedImagePath,
          child: Image.file(
            File(pickedImagePath),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
