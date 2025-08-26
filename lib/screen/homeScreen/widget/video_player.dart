import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerItem({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _controller;
  bool _showControls = true;
  Timer? _hideControlsTimer;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });

    _startHideControlsTimer();
  }

  @override
  void dispose() {
    _controller.dispose();
    _hideControlsTimer?.cancel();
    super.dispose();
  }

  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel(); 
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _showControls = false; 
      });
    });
  }

  void _togglePlayback() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
      _showControls = true; 
    });
    _startHideControlsTimer();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showControls = true;
        });
        _startHideControlsTimer();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          height: 200,width: Get.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Video Player
              _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : const Center(child: CircularProgressIndicator()),

              if (_showControls)
                IconButton(
                  icon: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                    size: 50,
                  ),
                  onPressed: _togglePlayback,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
