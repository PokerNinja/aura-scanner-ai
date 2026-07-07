import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'face_analyzer_service.dart';

class CalculatedAura {
  final int score;
  final String phrase;
  
  CalculatedAura({required this.score, required this.phrase});
}

class AuraCalculator {
  static Future<CalculatedAura> calculate(FaceAnalysisResult face) async {
    final String jsonString = await rootBundle.loadString('assets/aura_phrases.json');
    final Map<String, dynamic> data = jsonDecode(jsonString);

    int score = 0; 
    String category = "Neutral";
    final random = Random();

    // Priority 1: High Confidence / Arrogance (Head tilted up)
    if (face.headTiltX > 10) { 
      score = 8000 + random.nextInt(5000); // 8,000 to 13,000
      category = "Confident";
    }
    // Priority 2: Insecurity (Head tilted down)
    else if (face.headTiltX < -10) { 
      score = -1000 - random.nextInt(3000); // -1,000 to -4,000
      category = "Insecure";
    }
    // Priority 3: Facial Expressions
    else if (face.smilingProbability > 0.7) {
      score = 3000 + random.nextInt(2000); // 3,000 to 5,000
      category = "High Smile";
    } 
    else if (face.smilingProbability < 0.2) {
      // Very slight chance for the "Sigma" outcome on neutral faces
      if (random.nextDouble() > 0.8) {
        score = 5000 + random.nextInt(2000); 
        category = "No Smile"; 
      } else {
        score = -500 - random.nextInt(1500); 
        category = "No Smile";
      }
    }
    // Priority 4: Suspicious (Eyes squinting)
    else if (face.leftEyeOpenProbability < 0.5 || face.rightEyeOpenProbability < 0.5) {
      score = -200 - random.nextInt(800);
      category = "Suspicious";
    }
    // Fallback: Neutral
    else {
      score = random.nextInt(100) - 50; // -50 to +50
      category = "Neutral";
    }

    final List<dynamic> phrases = data[category] ?? data["Neutral"];
    final String selectedPhrase = phrases[random.nextInt(phrases.length)];

    return CalculatedAura(score: score, phrase: selectedPhrase);
  }
}