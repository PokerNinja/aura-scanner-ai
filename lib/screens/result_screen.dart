import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../services/face_analyzer_service.dart';
import '../services/aura_calculator.dart';
import '../services/database_service.dart';
import '../models/scan_history.dart';
import '../widgets/bouncing_button.dart';

class ResultScreen extends StatefulWidget {
  final String imagePath;
  final FaceAnalysisResult faceResult;

  const ResultScreen({
    super.key,
    required this.imagePath,
    required this.faceResult,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  CalculatedAura? _calculatedAura;
  final GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _processAura();
  }

  Future<void> _processAura() async {
    final result = await AuraCalculator.calculate(widget.faceResult);
    if (mounted) {
      setState(() {
        _calculatedAura = result;
      });
    }
    _saveToHistory(result);
  }

  Future<void> _saveToHistory(CalculatedAura result) async {
    final scan = ScanHistory()
      ..imagePath = widget.imagePath
      ..auraScore = result.score
      ..phrase = result.phrase
      ..scanDate = DateTime.now()
      ..faceSmilingProbability = widget.faceResult.smilingProbability
      ..faceHeadTiltX = widget.faceResult.headTiltX;

    await DatabaseService.saveScan(scan);
  }

  Future<void> _captureAndShare() async {
    try {
      final RenderRepaintBoundary boundary =
          _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;
      final tempDir = await getTemporaryDirectory();
      final file = await File(
        '${tempDir.path}/aura_scan_${DateTime.now().millisecondsSinceEpoch}.png',
      ).writeAsBytes(byteData.buffer.asUint8List());
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'My Aura Score: ${_calculatedAura?.score ?? 0} — scan yours!',
      );
    } catch (e) {
      debugPrint('Share error: $e');
    }
  }

  static const List<Shadow> _textShadows = [
    Shadow(color: Colors.black, blurRadius: 10, offset: Offset(2, 2)),
    Shadow(color: Colors.black, blurRadius: 20, offset: Offset(0, 0)),
  ];

  @override
  Widget build(BuildContext context) {
    if (_calculatedAura == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    final bool positive = _calculatedAura!.score > 0;
    final String scoreText =
        '${positive ? "+" : ""}${_calculatedAura!.score}';

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Visual content captured by RepaintBoundary
          RepaintBoundary(
            key: _globalKey,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.file(
                  File(widget.imagePath),
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.black.withValues(alpha: 0.35),
                ),

                // TOP: AURA SCORE label + numeric score
                SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'AURA SCORE',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.95),
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 6.0,
                              shadows: _textShadows,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            scoreText,
                            style: TextStyle(
                              color:
                                  positive ? Colors.greenAccent : Colors.redAccent,
                              fontSize: 80,
                              fontWeight: FontWeight.w900,
                              height: 1.0,
                              shadows: _textShadows,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // BOTTOM: Phrase only (inside boundary)
                Positioned(
                  bottom: 120,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      _calculatedAura!.phrase,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                        shadows: _textShadows,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Action buttons outside RepaintBoundary
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BouncingButton(
                      onTap: () => Navigator.pop(context),
                      child: _ActionBtnBody(
                        text: 'RESCAN',
                        bgColor: Colors.white.withValues(alpha: 0.2),
                        textColor: Colors.white,
                      ),
                    ),
                    BouncingButton(
                      onTap: _captureAndShare,
                      child: const _ActionBtnBody(
                        text: 'SHARE AURA',
                        bgColor: Colors.black,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionBtnBody extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;

  const _ActionBtnBody({
    required this.text,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
