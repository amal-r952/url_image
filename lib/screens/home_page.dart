import 'dart:html' as html;

import 'package:flutter/material.dart';

import '../widgets/build_html_image_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController imageUrlController = TextEditingController();
  String? imageUrl;
  bool isFullScreen = false;
  bool isMenuVisible = false;

  // Closes the menu by setting its visibility to false
  void closeMenu() {
    setState(() {
      isMenuVisible = false;
    });
  }

  // Toggles the full-screen mode
  void enterFullScreen() {
    setState(() {
      isFullScreen = true;
    });
    html.document.documentElement?.requestFullscreen();
  }

  // Exits full-screen mode
  void exitFullScreen() {
    setState(() {
      isFullScreen = false;
    });
    html.document.exitFullscreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              if (imageUrl != null && imageUrl!.isNotEmpty)
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onDoubleTap: isFullScreen
                          ? exitFullScreen
                          : enterFullScreen, 
                      child: BuildHtmlImageWidget(imageUrl: imageUrl!),
                    ),
                  ),
                ),
            ],
          ),
         
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 100),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: imageUrlController,
                      decoration: const InputDecoration(
                        hintText: "Enter the image url!",
                        border: OutlineInputBorder(
                            gapPadding: 16,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      onChanged: (value) {
                        setState(() {
                          imageUrl =
                              null;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        imageUrl = imageUrlController.text.trim();
                      });
                    },
                    child: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
          ),
          //menu for fullscreen actions
          if (isMenuVisible)
            GestureDetector(
              onTap: closeMenu,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          if (isMenuVisible)
            Positioned(
              bottom: 80,
              right: 25,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      enterFullScreen();
                      closeMenu();
                    },
                    child: const Text('Enter Fullscreen'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      exitFullScreen();
                      closeMenu();
                    },
                    child: const Text('Exit Fullscreen'),
                  ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isMenuVisible = !isMenuVisible; 
          });
        },
        child: const Icon(Icons.menu),
      ),
    );
  }
}
