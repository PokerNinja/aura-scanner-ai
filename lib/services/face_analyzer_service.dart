import 'dart:io';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:flutter/material.dart';

class FaceAnalysisResult {
  final double smilingProbability;
  final double leftEyeOpenProbability;
  final double rightEyeOpenProbability;
  final double headTiltX;
  final double headTiltY;
  final double headTiltZ;
  final Rect boundingBox;

  FaceAnalysisResult({
    required this.smilingProbability,
    required this.leftEyeOpenProbability,
    required this.rightEyeOpenProbability,
    required this.headTiltX,
    required this.headTiltY,
    required this.headTiltZ,
    required this.boundingBox,
  });
}

class FaceAnalyzerService {
  final FaceDetector _faceDetector;

  FaceAnalyzerService()
      : _faceDetector = FaceDetector(
          options: FaceDetectorOptions(
            enableClassification: true,
            enableLandmarks: true,
            enableContours: false,
            enableTracking: false,
            performanceMode: FaceDetectorMode.accurate,
          ),
        );

  Future<FaceAnalysisResult?> analyzeImage(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);

    try {
      final List<Face> faces = await _faceDetector.processImage(inputImage);

      if (faces.isEmpty) {
        return null;
      }

      final Face primaryFace = faces.first;

      return FaceAnalysisResult(
        smilingProbability: primaryFace.smilingProbability ?? 0.0,
        leftEyeOpenProbability: primaryFace.leftEyeOpenProbability ?? 0.0,
        rightEyeOpenProbability: primaryFace.rightEyeOpenProbability ?? 0.0,
        headTiltX: primaryFace.headEulerAngleX ?? 0.0,
        headTiltY: primaryFace.headEulerAngleY ?? 0.0,
        headTiltZ: primaryFace.headEulerAngleZ ?? 0.0,
        boundingBox: primaryFace.boundingBox,
      );
    } catch (e) {
      debugPrint('Face detection error: $e');
      return null;
    }
  }

  void dispose() {
    _faceDetector.close();
  }
}
