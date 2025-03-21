import 'dart:async';
import 'package:capitalhub_crm/controller/documentController/document_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/dilogue/campaignDilogue/pitch_recording_create.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';

class PitchRecordingScreen extends StatefulWidget {
  @override
  _PitchRecordingScreenState createState() => _PitchRecordingScreenState();
}

class _PitchRecordingScreenState extends State<PitchRecordingScreen> {
  List<String> videoItems = [
    "https://www.youtube.com/watch?v=mr3sBf3ID5I",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    "https://www.youtube.com/watch?v=H05oQPgkUt8",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "https://www.youtube.com/watch?v=CS0xyEvxbS8",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  ];

  Map<int, dynamic> videoControllers = {}; // Store controllers
  int? playingIndex;
  Map<int, bool> showControls = {};
  Timer? hideControlTimer;
  DocumentController documentController = Get.find();
  @override
  void dispose() {
    videoControllers.forEach((key, controller) {
      if (controller is VideoPlayerController) {
        controller.dispose();
      } else if (controller is YoutubePlayerController) {
        controller.dispose();
      }
    });
    hideControlTimer?.cancel();
    super.dispose();
  }

  bool isYouTubeVideo(String url) {
    return url.contains("youtube.com") || url.contains("youtu.be");
  }

  void initializeVideo(int index) {
    String url = videoItems[index];

    if (playingIndex != null && playingIndex != index) {
      if (videoControllers[playingIndex] is VideoPlayerController) {
        videoControllers[playingIndex]?.pause();
      }
    }

    if (!videoControllers.containsKey(index)) {
      if (isYouTubeVideo(url)) {
        final videoId = YoutubePlayer.convertUrlToId(url);
        videoControllers[index] = YoutubePlayerController(
            initialVideoId: videoId!,
            flags: const YoutubePlayerFlags(autoPlay: true));
      } else {
        final controller = VideoPlayerController.network(url);
        controller.initialize().then((_) {
          setState(() {});
          controller.play();
        });
        videoControllers[index] = controller;
      }
    } else {
      if (videoControllers[index] is VideoPlayerController) {
        videoControllers[index].play();
      }
    }

    setState(() {
      playingIndex = index;
      showControls[index] = true;
      startHideControlsTimer(index);
    });
  }

  void startHideControlsTimer(int index) {
    hideControlTimer?.cancel();
    hideControlTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        showControls[index] = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Pitch Recording"),
        body: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemCount: videoItems.length,
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 80),
          itemBuilder: (context, index) {
            String url = videoItems[index];

            if (videoControllers.containsKey(index)) {
              if (isYouTubeVideo(url)) {
                return YoutubePlayer(
                  controller: videoControllers[index],
                );
              } else {
                final videoController =
                    videoControllers[index] as VideoPlayerController;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      showControls[index] = !(showControls[index] ?? false);
                    });
                    if (showControls[index] == true) {
                      startHideControlsTimer(index);
                    }
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (!videoController.value.isPlaying)
                        AspectRatio(
                          aspectRatio: videoController.value.aspectRatio,
                          child: Image.network(
                            'https://media1.thrillophilia.com/filestore/v7h4ylcvnjh7dkpxg85jgw5gfqx4_IMG%20World%20Dubai%20Fun%20(1).jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      if (!videoController.value.isPlaying)
                        Positioned(
                          child: IconButton(
                            icon: Icon(Icons.play_arrow,
                                color: AppColors.white, size: 50),
                            onPressed: () => initializeVideo(index),
                          ),
                        ),
                      if (videoController.value.isPlaying)
                        AspectRatio(
                          aspectRatio: videoController.value.aspectRatio,
                          child: VideoPlayer(videoController),
                        ),
                      if (showControls[index] ?? false)
                        Positioned(
                          child: IconButton(
                            icon: Icon(
                              videoController.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: AppColors.white,
                              size: 50,
                            ),
                            onPressed: () {
                              if (videoController.value.isPlaying) {
                                videoController.pause();
                              } else {
                                initializeVideo(index);
                              }
                              setState(() {});
                            },
                          ),
                        ),
                      if (showControls[index] ?? false)
                        Positioned(
                          bottom: 10,
                          left: 10,
                          right: 10,
                          child: VideoProgressIndicator(
                            videoController,
                            allowScrubbing: true,
                            colors: VideoProgressColors(
                              playedColor: AppColors.redColor,
                              bufferedColor: AppColors.grey,
                              backgroundColor: Colors.black54,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }
            } else {
              return GestureDetector(
                onTap: () => initializeVideo(index),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      isYouTubeVideo(url)
                          ? 'https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(url)}/hqdefault.jpg'
                          : 'https://media1.thrillophilia.com/filestore/v7h4ylcvnjh7dkpxg85jgw5gfqx4_IMG%20World%20Dubai%20Fun%20(1).jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                    Icon(Icons.play_circle_fill,
                        size: 50, color: AppColors.white),
                  ],
                ),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            createPitchRecording(context, () {
              // documentController.
            });
          },
          backgroundColor: AppColors.primary,
          child: Icon(Icons.add, color: AppColors.white),
        ),
      ),
    );
  }
}
