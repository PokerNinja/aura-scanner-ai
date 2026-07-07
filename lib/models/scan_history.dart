import 'package:isar/isar.dart';

part 'scan_history.g.dart';

@collection
class ScanHistory {
  Id id = Isar.autoIncrement;

  late String imagePath;
  
  late int auraScore;
  
  late String phrase;
  
  late DateTime scanDate;
  
  @Index(type: IndexType.value)
  late double faceSmilingProbability;
  
  late double faceHeadTiltX;
}
