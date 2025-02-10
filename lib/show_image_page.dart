
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class ShowImage extends StatelessWidget {
  final Uint8List bytes;
  final ui.Rect rect;
  final Uint8List overlayImageBytes; // تصویر جایگزین مستطیل

  const ShowImage(this.bytes, this.rect, this.overlayImageBytes, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Captured Image'),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return FutureBuilder<ui.Image>(
              future: decodeImageFromList(bytes),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  final image = snapshot.data!;
                  final scaleX = constraints.maxWidth / image.width;
                  final scaleY = constraints.maxHeight / image.height;

                  double height = rect.bottom - rect.top;

                  final scaledRect = ui.Rect.fromLTRB(
                    rect.left * scaleX - 20,
                    (rect.top * scaleY) - (height * 1.2),
                    rect.right * scaleX + 20,
                    rect.bottom * scaleY + (height * 0.2),
                  );

                  return FutureBuilder<ui.Image>(
                    future: decodeImageFromList(overlayImageBytes),
                    builder: (context, overlaySnapshot) {
                      if (overlaySnapshot.connectionState ==
                              ConnectionState.done &&
                          overlaySnapshot.hasData) {
                        final overlayImage = overlaySnapshot.data!;
                        return Stack(
                          children: [
                            Image.memory(
                              bytes,
                              fit: BoxFit.contain,
                              width: constraints.maxWidth,
                              height: constraints.maxHeight,
                            ),
                            CustomPaint(
                              painter: ImagePainter(scaledRect, overlayImage),
                            ),
                          ],
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class ImagePainter extends CustomPainter {
  final ui.Rect rect;
  final ui.Image overlayImage;

  ImagePainter(this.rect, this.overlayImage);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImageRect(
      overlayImage, // تصویر ورودی
      ui.Rect.fromLTWH(
        0,
        0,
        overlayImage.width.toDouble(),
        overlayImage.height.toDouble(),
      ), // کل تصویر ورودی
      rect, // موقعیت و اندازه‌ای که تصویر باید کشیده شود
      Paint(),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
