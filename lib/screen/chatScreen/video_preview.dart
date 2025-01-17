import 'dart:io';

import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoPlayerPreview extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerPreview({Key? key, required this.videoUrl})
      : super(key: key);

  @override
  _VideoPlayerPreviewState createState() => _VideoPlayerPreviewState();
}

class _VideoPlayerPreviewState extends State<VideoPlayerPreview> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl,)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? VideoPlayer(_controller)
        : Center(child: CircularProgressIndicator());
  }
}

class FullscreenVideoPlayer extends StatelessWidget {
  final String videoUrl;
  final bool isNetworkUrl;

  const FullscreenVideoPlayer(
      {super.key, required this.videoUrl, this.isNetworkUrl = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: HelperAppBar.appbarHelper(title: ""),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child:
              VideoPlayerScreen(videoUrl: videoUrl, isNetworkUrl: isNetworkUrl),
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final bool isNetworkUrl;

  const VideoPlayerScreen(
      {super.key, required this.videoUrl, this.isNetworkUrl = true});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.isNetworkUrl
        ? VideoPlayerController.network(widget.videoUrl)
        : VideoPlayerController.file(File(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : Center(child: CircularProgressIndicator());
  }
}
