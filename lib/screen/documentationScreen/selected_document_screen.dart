import 'dart:convert';
import 'dart:io';

import 'package:capitalhub_crm/controller/documentController/document_controller.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../model/01-StartupModel/documentationModel/documentation_model.dart';
import '../../utils/appcolors/app_colors.dart';
import '../../utils/constant/app_var.dart';
import '../../utils/helper/helper.dart';
import '../drawerScreen/drawer_screen.dart';

class SelectedDocumentScreen extends StatefulWidget {
  // List<PlatformFile> selectedFiles;
  String title;
  SelectedDocumentScreen({super.key, required this.title});

  @override
  State<SelectedDocumentScreen> createState() => _SelectedDocumentScreenState();
}

class _SelectedDocumentScreenState extends State<SelectedDocumentScreen> {
  DocumentController documentController = Get.find();
  String postFolderName = "";
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      documentController.selectedFiles.clear();
      postFolderName = widget.title == "Legal & Compliance"
          ? "legal and compliance"
          : widget.title.replaceAll(" ", "").toLowerCase();
      documentController.getDocument(postFolderName);
    });
    super.initState();
  }

  void _selectDocuments() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
    );

    if (result != null) {
      // Manually filter files based on extension
      List<PlatformFile> filteredFiles = result.files.where((file) {
        final extension = file.extension?.toLowerCase();
        return extension == 'pdf' ||
            extension == 'png' ||
            extension == 'jpg' ||
            extension == 'jpeg';
      }).toList();

      setState(() {
        documentController.selectedFiles.addAll(filteredFiles);
      });
    }
  }

  void _removeDocument(int index) {
    setState(() {
      documentController.selectedFiles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        drawer: const DrawerWidget(),
        appBar: HelperAppBar.appbarHelper(title: widget.title),
        body: Obx(() => documentController.isLoading.value
            ? Helper.pageLoading()
            : documentController.docList.isEmpty &&
                    documentController.selectedFiles.isEmpty
                ? const Center(
                    child: TextWidget(
                        text: "No Data Found",
                        fontWeight: FontWeight.w500,
                        textSize: 16))
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GridView.builder(
                            itemCount: documentController.docList.length,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  _previewDocument(
                                      true,
                                      documentController.docList[index],
                                      PlatformFile(name: "", size: 0));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.blackCard,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        documentController
                                                    .docList[index].extension ==
                                                'pdf'
                                            ? Icons.picture_as_pdf_outlined
                                            : Icons.image_outlined,
                                        color: AppColors.redColor,
                                        size: 45,
                                      ),
                                      const SizedBox(height: 3),
                                      TextWidget(
                                        text: documentController
                                            .docList[index].fileName!,
                                        textSize: 10,
                                      ),
                                      const SizedBox(height: 3),
                                      InkWell(
                                          onTap: () {
                                            documentController.deleteDocument(
                                                postFolderName,
                                                documentController
                                                    .docList[index].id!);
                                          },
                                          child: const Icon(
                                              Icons.delete_outline_outlined,
                                              color: AppColors.redColor)),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          if (documentController.selectedFiles.isNotEmpty)
                            const TextWidget(text: "New added", textSize: 12),
                          const SizedBox(height: 12),
                          GridView.builder(
                            itemCount: documentController.selectedFiles.length,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemBuilder: (context, index) {
                              final file =
                                  documentController.selectedFiles[index];
                              return InkWell(
                                onTap: () {
                                  _previewDocument(false, DocData(), file);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.blackCard,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        file.extension == 'pdf'
                                            ? Icons.picture_as_pdf_outlined
                                            : Icons.image_outlined,
                                        color: AppColors.redColor,
                                        size: 45,
                                      ),
                                      const SizedBox(height: 3),
                                      TextWidget(
                                        text: file.name,
                                        textSize: 10,
                                      ),
                                      const SizedBox(height: 3),
                                      InkWell(
                                          onTap: () {
                                            _removeDocument(index);
                                          },
                                          child: const Icon(
                                              Icons.delete_outline_outlined,
                                              color: AppColors.redColor)),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )),
        floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          onPressed: _selectDocuments,
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: documentController.selectedFiles.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: AppButton.primaryButton(
                    onButtonPressed: () {
                      _uploadDocuments();
                    },
                    title: "Upload"),
              )
            : const SizedBox(),
      ),
    );
  }

  void _uploadDocuments() async {
    String folderName = postFolderName;
    List<Map<String, String>> files = [];

    for (PlatformFile file in documentController.selectedFiles) {
      if (file.path != null) {
        // Read the file as bytes
        File fileObj = File(file.path!);
        List<int> fileBytes = await fileObj.readAsBytes();

        // Convert to Base64
        String base64String = base64Encode(fileBytes);

        // Create the file map
        files.add({
          "name": file.name,
          "base64": base64String,
        });
      }
    }
    Map<String, dynamic> uploadObject = {
      "folder_name": folderName,
      "files": files,
    };
    documentController.uploadDocument(uploadObject).then((v) {
      documentController.selectedFiles.clear();
      setState(() {});
    });
  }

  void _previewDocument(bool isNetwork, DocData docdata, PlatformFile file) {
    isNetwork
        ? Helper.launchUrl(docdata.fileUrl!)
        : showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              backgroundColor: AppColors.transparent,
              contentPadding: const EdgeInsets.all(0),
              content: Container(
                padding: const EdgeInsets.all(0),
                child: file.extension == 'pdf'
                    ? Container(
                        height: 400,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: SfPdfViewer.file(File(file.path!)),
                      )
                    : Container(
                        height: 400,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: FileImage(
                                  File(file.path!),
                                ))),
                      ),
              ),
            ),
          );
  }
}
