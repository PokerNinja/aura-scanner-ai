import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/scan_history.dart';

class HistoryDetailScreen extends StatefulWidget {
  final ScanHistory scan;

  const HistoryDetailScreen({super.key, required this.scan});

  @override
  State<HistoryDetailScreen> createState() => _HistoryDetailScreenState();
}

class _HistoryDetailScreenState extends State<HistoryDetailScreen> {
  final GlobalKey _globalKey = GlobalKey();
  bool _isSharing = false;

  Future<void> _captureAndShare() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);

    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      
      if (byteData != null) {
        final directory = await getTemporaryDirectory();
        final imagePath = await File('${directory.path}/shared_aura_${DateTime.now().millisecondsSinceEpoch}.png').create();
        await imagePath.writeAsBytes(byteData.buffer.asUint8List());
        
        await Share.shareXFiles([XFile(imagePath.path)], text: 'Check out my Aura Score!');
      }
    } catch (e) {
      debugPrint('Error sharing: $e');
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          RepaintBoundary(
            key: _globalKey,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.file(
                  File(widget.scan.imagePath),
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.black.withValues(alpha: 0.6),
                ),
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Column(
                          children: [
                            Text(
                              'AURA SCORE',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 18,
                                letterSpacing: 3.0,
                                fontWeight: FontWeight.bold,
                                shadows: const [Shadow(color: Colors.black, blurRadius: 10, offset: Offset(2, 2))],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${widget.scan.auraScore > 0 ? "+" : ""}${widget.scan.auraScore}',
                              style: TextStyle(
                                color: widget.scan.auraScore > 0 ? Colors.greenAccent : Colors.redAccent,
                                fontSize: 72,
                                fontWeight: FontWeight.w900,
                                shadows: const [Shadow(color: Colors.black, blurRadius: 15, offset: Offset(2, 2))],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 120.0, left: 32.0, right: 32.0),
                        child: Text(
                          widget.scan.phrase,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            height: 1.2,
                            shadows: [Shadow(color: Colors.black, blurRadius: 15, offset: Offset(2, 2))],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: _captureAndShare,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: _isSharing
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2),
                        )
                      : const Text(
                          'SHARE AURA',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 16),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
