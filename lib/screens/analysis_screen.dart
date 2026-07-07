import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/face_analyzer_service.dart';
import 'result_screen.dart';

class AnalysisScreen extends StatefulWidget {
  final String imagePath;

  const AnalysisScreen({super.key, required this.imagePath});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  final FaceAnalyzerService _faceAnalyzer = FaceAnalyzerService();
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;
  bool _isAnalysisComplete = false;
  FaceAnalysisResult? _analysisResult;
  
  bool _hasNavigated = false;
  Timer? _failsafeTimer;

  // TEST AD UNIT ID - Replace with production ID before launch
  final String _adUnitId = 'ca-app-pub-3940256099942544/1033173712';

  @override
  void initState() {
    super.initState();
    
    // Absolute Failsafe: 7 seconds maximum waiting time.
    _failsafeTimer = Timer(const Duration(seconds: 7), () {
      _forceNavigate();
    });
    
    _loadInterstitialAd();
    _runAnalysis();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isAdLoaded = true;
          _checkAndProceed();
        },
        onAdFailedToLoad: (error) {
          debugPrint('InterstitialAd failed to load: $error');
          _isAdLoaded = true; // Proceed anyway without ad
          _checkAndProceed();
        },
      ),
    );
  }

  Future<void> _runAnalysis() async {
    // Fake processing time for UX
    await Future.delayed(const Duration(seconds: 2));
    
    FaceAnalysisResult? result = await _faceAnalyzer.analyzeImage(widget.imagePath);
    
    // Fallback logic if ML Kit fails to detect a face (prevents infinite loading)
    if (result == null) {
      result = FaceAnalysisResult(
        smilingProbability: 0.5,
        leftEyeOpenProbability: 1.0,
        rightEyeOpenProbability: 1.0,
        headTiltX: 0.0,
        headTiltY: 0.0,
        headTiltZ: 0.0,
        boundingBox: Rect.zero,
      );
    }
    
    _analysisResult = result;
    _isAnalysisComplete = true;
    _checkAndProceed();
  }

  void _checkAndProceed() {
    if (_isAnalysisComplete && _isAdLoaded && !_hasNavigated && mounted) {
      if (_interstitialAd != null) {
        // Cancel timer when ad is showing to prevent background navigation
        _failsafeTimer?.cancel();
        
        _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            ad.dispose();
            _forceNavigate();
          },
          onAdFailedToShowFullScreenContent: (ad, error) {
            ad.dispose();
            _forceNavigate();
          },
        );
        _interstitialAd!.show();
      } else {
        _forceNavigate();
      }
    }
  }

  void _forceNavigate() {
    if (_hasNavigated || !mounted) return;
    _hasNavigated = true;
    _failsafeTimer?.cancel();
    
    // Safety check again for analysis result
    final finalResult = _analysisResult ?? FaceAnalysisResult(
      smilingProbability: 0.5,
      leftEyeOpenProbability: 1.0,
      rightEyeOpenProbability: 1.0,
      headTiltX: 0.0,
      headTiltY: 0.0,
      headTiltZ: 0.0,
      boundingBox: Rect.zero,
    );
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          imagePath: widget.imagePath,
          faceResult: finalResult,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _failsafeTimer?.cancel();
    _faceAnalyzer.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(height: 24),
            Text(
              'ANALYZING AURA...',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}