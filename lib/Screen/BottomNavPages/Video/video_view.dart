import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String? videoPath;
  const VideoView({Key? key, this.videoPath}) : super(key: key);

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  ///list of buttons
  List<Widget> buttonsList = const [
    Icon(
      Icons.download,
      color: Colors.white,
    ),
    Icon(
      Icons.share,
      color: Colors.white,
    ),
  ];

  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();

    _chewieController = ChewieController(
        videoPlayerController: VideoPlayerController.file(
          File(widget.videoPath!),
        ),
        autoInitialize: true,
        autoPlay: true,
        looping: true,
        aspectRatio: 5 / 6,
        materialProgressColors: ChewieProgressColors(
          backgroundColor: Colors.black,
          bufferedColor: Colors.white,
        ),
        errorBuilder: ((context, errorMessage) {
          return Center(
            child: Text(errorMessage),
          );
        }));
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController!.pause();
    _chewieController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2B3047),
      appBar: AppBar(
        toolbarHeight: 90,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Download Video',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 90.0, left: 20, right: 20),
        child: Chewie(controller: _chewieController!),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 25, bottom: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(buttonsList.length, (index) {
              return FloatingActionButton(
                backgroundColor: Colors.black,
                heroTag: "$index",
                onPressed: () {
                  switch (index) {
                    case 0:
                      log("download video");
                      ImageGallerySaver.saveFile(widget.videoPath!)
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Video Saved")));
                      });
                      break;

                    case 1:
                      log("Share");
                      FlutterNativeApi.shareImage(widget.videoPath!);

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
