import 'dart:async';
import 'package:capitalhub_crm/controller/documentController/document_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/dilogue/campaignDilogue/pitch_recording_create.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';

import '../../model/documentationModel/pitch_recording_model.dart';

class PitchRecordingScreen extends StatefulWidget {
  @override
  _PitchRecordingScreenState createState() => _PitchRecordingScreenState();
}

class _PitchRecordingScreenState extends State<PitchRecordingScreen> {
  // List<String> videoItems = [
  //   "https://www.youtube.com/watch?v=mr3sBf3ID5I",
  //   "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  //   "https://www.youtube.com/watch?v=H05oQPgkUt8",
  //   "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  //   "https://www.youtube.com/watch?v=CS0xyEvxbS8",
  //   "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  // ];

  Map<int, dynamic> videoControllers = {};
  int? playingIndex;
  Map<int, bool> showControls = {};
  Timer? hideControlTimer;
  DocumentController documentController = Get.find();
  @override
  void initState() {
    documentController.fetchPitchRecord();
    super.initState();
  }

  @override
  void dispose() {
    disposeFunction();
    super.dispose();
  }

  disposeFunction() {
    videoControllers.forEach((key, controller) {
      if (controller is VideoPlayerController) {
        controller.dispose();
      } else if (controller is YoutubePlayerController) {
        controller.dispose();
      }
    });
    hideControlTimer?.cancel();
  }

  bool isYouTubeVideo(String url) {
    return url.contains("youtube.com") || url.contains("youtu.be");
  }

  void initializeVideo(int index) {
    String url = documentController.pitchRecordList[index].videoUrl!;

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
        body: Obx(
          () => documentController.isLoadingPitch.value
              ? Helper.pageLoading()
              : ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemCount: documentController.pitchRecordList.length,
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 12, bottom: 80),
                  itemBuilder: (context, index) {
                    PitchRecord data =
                        documentController.pitchRecordList[index];

                    if (videoControllers.containsKey(index)) {
                      if (isYouTubeVideo(data.videoUrl!)) {
                        return Stack(
                          children: [
                            YoutubePlayer(
                              controller: videoControllers[index],
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: InkWell(
                                onTap: () {
                                  Helper.loader(context);
                                  documentController
                                      .deletePitch(data.folderName!, data.id!)
                                      .then((v) {});
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: AppColors.whiteCard,
                                  child: const Icon(Icons.delete,
                                      size: 20, color: AppColors.redColor),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        final videoController =
                            videoControllers[index] as VideoPlayerController;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              showControls[index] =
                                  !(showControls[index] ?? false);
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
                                  aspectRatio:
                                      videoController.value.aspectRatio,
                                  child: Image.network(
                                    '${documentController.pitchRecordList[index].fileUrl}',
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
                                  aspectRatio:
                                      videoController.value.aspectRatio,
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
                              Positioned(
                                top: 10,
                                right: 10,
                                child: InkWell(
                                  onTap: () {
                                    Helper.loader(context);
                                    documentController
                                        .deletePitch(data.folderName!, data.id!)
                                        .then((v) {});
                                  },
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: AppColors.whiteCard,
                                    child: const Icon(Icons.delete,
                                        size: 20, color: AppColors.redColor),
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
                              data.fileUrl!,
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            documentController.base64Image = null;
            documentController.videoUrlController.clear();
            createPitchRecording(context, () {
              Helper.loader(context);
              documentController.createPitchRecording();
            });
          },
          backgroundColor: AppColors.primary,
          child: Icon(Icons.add, color: AppColors.white),
        ),
      ),
    );
  }
}
