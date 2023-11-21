import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageView extends StatefulWidget {
  final String? imagePath;
  const ImageView({Key? key, this.imagePath}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  ///list of buttons
  List<Widget> buttonsList = const [
    Icon(
      Icons.download,
      color: Colors.white,
    ),
    Icon(
      Icons.print,
      color: Colors.white,
    ),
    Icon(
      Icons.share,
      color: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2B3047),
      appBar: AppBar(
        toolbarHeight: 80,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Download Image',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 20),
        child: Container(
          height: 500,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0, // soften the shadow
                spreadRadius: 5.0, //extend the shadow
                offset: Offset(
                  5.0, // Move to right 10  horizontally
                  5.0, // Move to bottom 10 Vertically
                ),
              )
            ],
            color: Colors.black,
            image: DecorationImage(
                fit: BoxFit.cover, image: FileImage(File(widget.imagePath!))),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 25, bottom: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(buttonsList.length, (index) {
              return FloatingActionButton(
                backgroundColor: Colors.black,
                heroTag: "$index",
                onPressed: () async {
                  switch (index) {
                    case 0:
                      log("download image");
                      ImageGallerySaver.saveFile(widget.imagePath!)
                          .then((value) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            "Image Saved",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.black,
                        ));
                      });
                      break;
                    case 1:
                      log("Print");
                      FlutterNativeApi.printImage(
                          widget.imagePath!, widget.imagePath!.split("/").last);
                      break;
                    case 2:
                      log("Share");
                      FlutterNativeApi.shareImage(widget.imagePath!);
                      break;
                  }
                },
                child: buttonsList[index],
              );
            })),
      ),
    );
  }
}
