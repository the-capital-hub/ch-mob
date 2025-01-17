import 'dart:io';

import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DocPreviewScreen extends StatefulWidget {
  String url;
  bool? isNetworkUrl;
  DocPreviewScreen({super.key, required this.url, required this.isNetworkUrl});

  @override
  State<DocPreviewScreen> createState() => _DocPreviewScreenState();
}

class _DocPreviewScreenState extends State<DocPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelperAppBar.appbarHelper(title: "Document"),
      body: widget.isNetworkUrl == true
          ? SfPdfViewer.network(widget.url)
          : SfPdfViewer.file(File(widget.url)),
    );
  }
}
