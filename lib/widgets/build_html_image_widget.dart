import 'dart:html' as html;
import 'dart:ui_web' as ui;

import 'package:flutter/material.dart';

class BuildHtmlImageWidget extends StatefulWidget {
  final String imageUrl;
  const BuildHtmlImageWidget({super.key, required this.imageUrl});

  @override
  State<BuildHtmlImageWidget> createState() => _BuildHtmlImageWidgetState();
}

class _BuildHtmlImageWidgetState extends State<BuildHtmlImageWidget> {
  late String viewType;

  // Registers the HTML image view when the widget is initialized or updated
  void createImageView() {
    viewType = 'html-image-${DateTime.now().millisecondsSinceEpoch}';

    // Registering a view factory to create an HTML image element
    ui.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
      final imgElement = html.ImageElement()
        ..src = widget.imageUrl
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.objectFit =
            'contain'; 

      return imgElement;
    });

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    createImageView(); 
  }

  @override
  void didUpdateWidget(BuildHtmlImageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Re-register the image view if the image URL has changed
    if (oldWidget.imageUrl != widget.imageUrl) {
      createImageView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 500,
      child: HtmlElementView(
          viewType: viewType), 
    );
  }
}
