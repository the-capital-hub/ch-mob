import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:capitalhub_crm/controller/createPostController/create_post_controller.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart'
    as html;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:video_player/video_player.dart';
import '../../widget/imagePickerWidget/image_picker_widget.dart';
import '../profileScreen/polls_widget_profile.dart';
import 'polladd_dilogue.dart';
import 'package:path_provider/path_provider.dart';

class CreatePostScreen extends StatefulWidget {
  String? postid;
  bool? isPublicPost;
  CreatePostScreen({this.postid, super.key, this.isPublicPost});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  CreatePostController createPostController = Get.put(CreatePostController());
  var isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    createPostController.isPublicPost = widget.isPublicPost ?? true;
    if (widget.postid != null) {
      isLoading.value = true;
      createPostController.getPostDetail(widget.postid!).then((value) {
        isLoading.value = false;
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    createPostController.isCommunityPost = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
            backgroundColor: AppColors.transparent,
            drawer: const DrawerWidget(),
            appBar: HelperAppBar.appbarHelper(
                title: "Create Post", hideBack: true, autoAction: true),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(
                              '${GetStoreData.getStore.read('profile_image')}'),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                text: "${GetStoreData.getStore.read('name')}",
                                textSize: 16,
                                fontWeight: FontWeight.w500),
                            const SizedBox(height: 4),
                            if (!createPostController.isCommunityPost)
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      createPostController.isPublicPost =
                                          !createPostController.isPublicPost;
                                      setState(() {});
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: createPostController
                                                  .isPublicPost
                                              ? GetStoreData.getStore
                                                      .read('isInvestor')
                                                  ? AppColors.primaryInvestor
                                                  : AppColors.primary
                                              : AppColors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      child: TextWidget(
                                          text: "Public",
                                          color: GetStoreData.getStore
                                                  .read('isInvestor')
                                              ? createPostController
                                                      .isPublicPost
                                                  ? AppColors.black
                                                  : AppColors.white
                                              : AppColors.white,
                                          textSize: 13,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  InkWell(
                                    onTap: () {
                                      createPostController.isPublicPost =
                                          !createPostController.isPublicPost;
                                      setState(() {});
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: createPostController
                                                  .isPublicPost
                                              ? AppColors.transparent
                                              : GetStoreData.getStore
                                                      .read('isInvestor')
                                                  ? AppColors.primaryInvestor
                                                  : AppColors.primary,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      child: TextWidget(
                                          text: "Company",
                                          textSize: 13,
                                          color: GetStoreData.getStore
                                                  .read('isInvestor')
                                              ? createPostController
                                                      .isPublicPost
                                                  ? AppColors.white
                                                  : AppColors.black
                                              : AppColors.white,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        )
                      ],
                    ),
                    sizedTextfield,
                    MyCustomTextField.textField(
                        hintText: "What do you want to talk about ?",
                        controller: createPostController.titleController,
                        maxLine: widget.postid != null ? 7 : 15),
                    if (widget.postid != null && isLoading.value == false)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: isLoading.value
                            ? Helper.loader(context)
                            : resharedPostPreview(),
                      ),
                    sizedTextfield,
                    Card(
                      color: AppColors.blackCard,
                      surfaceTintColor: AppColors.blackCard,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: _pickImages,
                              child: CircleAvatar(
                                backgroundColor: AppColors.white12,
                                child: Icon(
                                  Icons.image_outlined,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: _pickVideo,
                              child: CircleAvatar(
                                backgroundColor: AppColors.white12,
                                child: Icon(
                                  Icons.videocam_outlined,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: _pickDocument,
                              child: CircleAvatar(
                                backgroundColor: AppColors.white12,
                                child: Icon(
                                  Icons.picture_as_pdf_outlined,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return PollOptionsDialog();
                                  },
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: AppColors.white12,
                                child: Icon(
                                  Icons.poll_outlined,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppButton.outlineButton(
                                onButtonPressed: () {
                                  _previewSelections();
                                },
                                title: "Preview"),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: AppButton.primaryButton(
                                onButtonPressed: () {
                                  createPostController
                                      .base64Convert(
                                          context,
                                          selectedImages,
                                          selectedVideo,
                                          selectedDocument,
                                          widget.postid ?? "")
                                      .th;
                                },
                                title: "Post"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  // List<File> selectedImages = [];
  File? selectedVideo;
  File? selectedDocument;
  VideoPlayerController? _videoController;

  final ImagePicker _picker = ImagePicker();
  List<Asset> selectedImages = [];
  List<Uint8List> imageByteData = [];

  Future<void> _pickImages() async {
    try {
      selectedImages.clear();
      imageByteData.clear();
      selectedImages = await MultiImagePicker.pickImages(
        selectedAssets: selectedImages,
      );
      // Pre-load images into memory for efficient display
      // for (var asset in selectedImages) {
      //   final byteData = await _getImageByteData(asset);
      //   imageByteData.add(byteData);
      // }
      List<File> croppedFiles = [];

      for (var asset in selectedImages) {
        final byteData = await _getImageByteData(asset);
        final tempFile = await _writeToTempFile(byteData);

        final croppedFilePath =
            await ImagePickerWidget().imgCropper(tempFile.path);

        if (croppedFilePath != null && croppedFilePath.isNotEmpty) {
          File croppedFile = File(croppedFilePath); // Convert path to File
          croppedFiles.add(croppedFile);

          final croppedBytes = await croppedFile.readAsBytes();
          imageByteData.add(croppedBytes);
        }
      }
    } catch (e) {
      print("Error picking images: $e");
    }
  }

  Future<File> _writeToTempFile(Uint8List bytes) async {
    final tempDir = await getTemporaryDirectory();
    final file =
        File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg');
    await file.writeAsBytes(bytes);
    return file;
  }

  Future<void> _pickVideo() async {
    try {
      final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          selectedVideo = File(pickedFile.path);
          _videoController = VideoPlayerController.file(selectedVideo!)
            ..initialize().then((_) {
              setState(() {});
            });
        });
      }
    } catch (e) {
      print("Error picking video: $e");
    }
  }

  Future<void> _pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
      if (result != null && result.files.single.path != null) {
        // Ensure the selected file is a PDF
        String filePath = result.files.single.path!;
        String fileExtension = filePath.split('.').last.toLowerCase();

        if (fileExtension == 'pdf') {
          setState(() {
            selectedDocument = File(filePath); // Store the picked PDF document
          });
        } else {
          HelperSnackBar.snackBar("Error", "Only PDF files are allowed.");
        }
      } else {
        print("No document selected.");
      }
    } catch (e) {
      print("Error picking document: $e");
    }
  }

  void _previewSelections() {
    if (_videoController != null) {
      _videoController!.play();
    }
    showModalBottomSheet(
      backgroundColor: AppColors.blackCard,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: StatefulBuilder(
          builder: (BuildContext context, setState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TextWidget(text: "Images", textSize: 14),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: selectedImages.isEmpty ? 0 : 150,
                    width: Get.width,
                    child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 8),
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedImages.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 150,
                            width: 150,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.memory(
                                      imageByteData[index],
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    )),
                                Positioned(
                                  top: -5,
                                  right: -5,
                                  child: IconButton(
                                    icon: const Icon(Icons.remove_circle,
                                        color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        selectedImages.removeAt(index);
                                        imageByteData.removeAt(index);
                                      });
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (selectedVideo != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextWidget(text: "Video", textSize: 14),
                            const SizedBox(height: 4),
                            SizedBox(
                              height: 200,
                              width: 150,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  _videoController!.value.isInitialized
                                      ? SizedBox(
                                          height: 200,
                                          width: 150,
                                          child: AspectRatio(
                                            aspectRatio: _videoController!
                                                .value.aspectRatio,
                                            child:
                                                VideoPlayer(_videoController!),
                                          ),
                                        )
                                      : const CircularProgressIndicator(),
                                  Positioned(
                                    top: -5,
                                    right: -5,
                                    child: IconButton(
                                      icon: const Icon(Icons.remove_circle,
                                          color: Colors.red),
                                      onPressed: () {
                                        setState(() {
                                          selectedVideo = null;
                                          _videoController?.dispose();
                                          _videoController = null;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      if (selectedDocument != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextWidget(text: "Document", textSize: 14),
                            const SizedBox(height: 4),
                            SizedBox(
                              height: 200,
                              width: 150,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  _buildDocumentPreview(selectedDocument!),
                                  Positioned(
                                    top: -5,
                                    right: -5,
                                    child: IconButton(
                                      icon: const Icon(Icons.remove_circle,
                                          color: Colors.red),
                                      onPressed: () {
                                        setState(() {
                                          selectedDocument = null;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  if (createPostController.pollOptions.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          const TextWidget(text: "Polls", textSize: 14),
                          IconButton(
                            icon: const Icon(Icons.remove_circle,
                                color: Colors.red),
                            onPressed: () {
                              createPostController.pollOptions.clear();
                              setState(() {});
                            },
                          ),
                        ]),
                        const SizedBox(height: 4),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: createPostController.pollOptions
                                .asMap()
                                .entries
                                .map((e) {
                              int index = e.key + 1;
                              String item = e.value;

                              return Row(
                                children: [
                                  TextWidget(
                                      text: "Option $index  -  ", textSize: 14),
                                  TextWidget(
                                    text: item,
                                    textSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              );
                            }).toList())
                      ],
                    )
                ],
              ),
            );
          },
        ),
      ),
    ).then((v) {
      _videoController!.pause();
    });
  }

  Future<Uint8List> _getImageByteData(Asset asset) async {
    final ByteData byteData = await asset.getByteData();
    return byteData.buffer.asUint8List(); // Convert ByteData to Uint8List
  }

  Widget _buildDocumentPreview(File document) {
    if (document.path.toLowerCase().endsWith('.pdf')) {
      return Container(
        width: 150,
        height: 200,
        child: SfPdfViewer.file(
          File(document.path),
        ),
      );
    } else {
      return Container(
        width: 150,
        height: 200,
        color: Colors.red,
        child: const Center(
          child: Text(
            'Invalid document type',
            style: TextStyle(color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }
  }

  Widget resharedPostPreview() {
    return SizedBox(
      width: Get.width,
      height: 250,
      child: Card(
        elevation: 3,
        shadowColor: AppColors.white12,
        color: AppColors.blackCard,
        surfaceTintColor: AppColors.blackCard,
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.transparent,
                    radius: 18,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          '${createPostController.postData.userProfilePicture}'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            TextWidget(
                                text:
                                    "${createPostController.postData.userFirstName} ${createPostController.postData.userLastName}",
                                textSize: 12),
                            const Expanded(child: SizedBox()),
                          ],
                        ),
                        // const SizedBox(height: 1),
                        TextWidget(
                          text:
                              "${createPostController.postData.userDesignation}  ${createPostController.postData.userLocation}",
                          textSize: 10,
                          color: AppColors.whiteCard,
                        ),
                        // const SizedBox(height: 1),
                        TextWidget(
                          text: "${createPostController.postData.age}",
                          textSize: 10,
                          color: AppColors.white54,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 0, color: AppColors.white38, thickness: 0.5),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  html.HtmlWidget(
                    "${createPostController.postData.description}",
                    // onTapUrl: (url) async {
                    //   return await launch(
                    //       url);
                    // },
                    textStyle: TextStyle(fontSize: 10, color: AppColors.white),
                  ),
                  const SizedBox(height: 6),
                  if (createPostController.postData.pollOptions!.isNotEmpty)
                    PollWidgetProfile(
                        pollOptions: createPostController.postData.pollOptions!,
                        totalVotes: createPostController.postData.totalVotes!,
                        myVotes: createPostController.postData.myVotes!),
                  createPostController.postData.images!.isEmpty
                      ? const SizedBox(height: 0)
                      : Column(children: [
                          SizedBox(
                            height: 133,
                            child: PageView.builder(
                              itemCount:
                                  createPostController.postData.images!.length,
                              onPageChanged: (ind) {},
                              itemBuilder: (context, ind) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(createPostController
                                          .postData.images![ind]),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ])
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
