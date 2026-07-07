import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/face_analyzer_service.dart';

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

  // TEST AD UNIT ID - Replace with production ID before launch
  final String _adUnitId = 'ca-app-pub-3940256099942544/1033173712';

  @override
  void initState() {
    super.initState();
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
          _isAdLoaded = true; // Proceed anyway if ad fails
          _checkAndProceed();
        },
      ),
    );
  }

  Future<void> _runAnalysis() async {
    // Artificial delay to ensure user sees the "Analyzing" state
    await Future.delayed(const Duration(seconds: 2));

    _analysisResult = await _faceAnalyzer.analyzeImage(widget.imagePath);
    _isAnalysisComplete = true;
    _checkAndProceed();
  }

  void _checkAndProceed() {
    if (_isAnalysisComplete && _isAdLoaded) {
      if (_interstitialAd != null) {
        _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            ad.dispose();
            _navigateToResult();
          },
          onAdFailedToShowFullScreenContent: (ad, error) {
            ad.dispose();
            _navigateToResult();
          },
        );
        _interstitialAd!.show();
      } else {
        _navigateToResult();
      }
    }
  }

  void _navigateToResult() {
    // ResultScreen will be implemented in Phase 3
    debugPrint('Navigating to Result. Smile Prob: ${_analysisResult?.smilingProbability}');
    Navigator.pop(context);
  }

  @override
  void dispose() {
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
