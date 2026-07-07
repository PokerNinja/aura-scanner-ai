import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/scan_history.dart';
import '../services/database_service.dart';
import 'history_detail_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<ScanHistory>> _scansFuture;

  @override
  void initState() {
    super.initState();
    _scansFuture = DatabaseService.getAllScans();
  }

  Color _auraColor(int score) {
    if (score >= 70) return const Color(0xFF00E676);
    if (score >= 40) return const Color(0xFFFFD600);
    return const Color(0xFFFF1744);
  }

  String _auraLabel(int score) {
    if (score >= 70) return '+$score';
    if (score >= 40) return '+$score';
    return '$score';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            Expanded(
              child: FutureBuilder<List<ScanHistory>>(
                future: _scansFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF9C27B0),
                        strokeWidth: 2,
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return _buildErrorState();
                  }
                  final scans = snapshot.data ?? [];
                  if (scans.isEmpty) {
                    return _buildEmptyState();
                  }
                  return _buildGrid(scans);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 8, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 12),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFFCE93D8), Color(0xFF7B1FA2)],
            ).createShader(bounds),
            child: const Text(
              'AURA JOURNAL',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.05),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.12),
                width: 1.5,
              ),
            ),
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 40,
              color: Colors.white.withValues(alpha: 0.3),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No Aura history found.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start scanning.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.35),
              fontSize: 14,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Text(
        'Could not load history.',
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.4),
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _buildGrid(List<ScanHistory> scans) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.68,
      ),
      itemCount: scans.length,
      itemBuilder: (context, index) => _ScanCard(
        scan: scans[index],
        auraColor: _auraColor(scans[index].auraScore),
        auraLabel: _auraLabel(scans[index].auraScore),
      ),
    );
  }
}

class _ScanCard extends StatefulWidget {
  final ScanHistory scan;
  final Color auraColor;
  final String auraLabel;

  const _ScanCard({
    required this.scan,
    required this.auraColor,
    required this.auraLabel,
  });

  @override
  State<_ScanCard> createState() => _ScanCardState();
}

class _ScanCardState extends State<_ScanCard> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails _) => setState(() => _scale = 0.95);
  void _onTapUp(TapUpDetails _) => setState(() => _scale = 1.0);
  void _onTapCancel() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    final file = File(widget.scan.imagePath);
    final formattedDate = DateFormat('MMM d, y').format(widget.scan.scanDate);

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HistoryDetailScreen(scan: widget.scan),
          ),
        );
      },
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Thumbnail
          file.existsSync()
              ? Image.file(file, fit: BoxFit.cover)
              : Container(
                  color: Colors.white.withValues(alpha: 0.06),
                  child: Icon(
                    Icons.person_outline_rounded,
                    size: 48,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                ),

          // Bottom gradient overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 28, 10, 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.92),
                    Colors.black.withValues(alpha: 0.0),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Aura score pill
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: widget.auraColor.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: widget.auraColor.withValues(alpha: 0.55),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      widget.auraLabel,
                      style: TextStyle(
                        color: widget.auraColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Phrase
                  Text(
                    widget.scan.phrase,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Date
                  Text(
                    formattedDate,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.45),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Top-right glow dot for score
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.auraColor,
                boxShadow: [
                  BoxShadow(
                    color: widget.auraColor.withValues(alpha: 0.7),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
        ),
      ),
    );
  }
}
