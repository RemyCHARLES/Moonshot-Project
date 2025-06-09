// lib/presentation/widgets/lesson_pages/beatmatch_page.dart
// ------------------------------------------------------------
// Beatquest – BeatmatchPage Widget
// ------------------------------------------------------------
// This widget is used to teach users timing alignment between two
// audio tracks (Track A and B). It provides playback controls,
// waveform placeholders, and a jog wheel to shift playback position.
//
// The user can play both loops simultaneously and validate whether
// the alignment is correct (within a tolerance).
//
// Features:
// - JustAudio player setup for both tracks
// - Visual waveform placeholders
// - Jog wheel adjustment buttons
// - Loop playback and sync validation
// ------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class BeatmatchPage extends StatefulWidget {
  final Map<String, dynamic> data;
  final void Function(bool isCorrect)? onValidated;

  const BeatmatchPage({super.key, required this.data, this.onValidated});

  @override
  State<BeatmatchPage> createState() => _BeatmatchPageState();
}

class _BeatmatchPageState extends State<BeatmatchPage> {
  late AudioPlayer playerA;  // Player for Track A (reference loop)
  late AudioPlayer playerB;  // Player for Track B (user-aligned loop)

  bool _hasValidated = false;
  bool _isCorrect = false;
  int _offsetMs = 0;

  static int _correctAnswers = 0;   // Track global correct count
  static int _incorrectAnswers = 0; // Track global incorrect count

  @override
  void initState() {
    super.initState();
    playerA = AudioPlayer();
    playerB = AudioPlayer();

    // Ensure both players loop continuously
    playerA.setLoopMode(LoopMode.one);
    playerB.setLoopMode(LoopMode.one);

    // Debug logging on state change
    playerA.playerStateStream.listen((state) {
      print("🎧 playerA → ${state.processingState}, playing: ${state.playing}");
    });
    playerB.playerStateStream.listen((state) {
      print("🎧 playerB → ${state.processingState}, playing: ${state.playing}");
    });

    _loadAudio();
  }

  /// Load audio files and optionally apply an initial offset
  Future<void> _loadAudio() async {
    try {
      final fileA = widget.data['fileA'];
      final fileB = widget.data['fileB'];
      final initialOffset = widget.data['initialOffsetMs'] ?? 0;

      if (fileA == null || fileB == null) {
        print('❌ Fichier audio manquant');
        return;
      }

      final urlA = 'http://localhost:18080/audio-files/$fileA';
      final urlB = 'http://localhost:18080/audio-files/$fileB';

      await playerA.setUrl(urlA);
      final resultB = await playerB.setUrl(urlB);
      if (resultB == null) {
        print('❌ Le chargement de playerB a échoué');
      } else {
        await playerB.seek(Duration(milliseconds: initialOffset));
      }
    } catch (e) {
      print('❌ Erreur chargement audio: $e');
    }
  }

  @override
  void dispose() {
    playerA.dispose();
    playerB.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Title
          const Text(
            '🎧 Beatmatch Exercise',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Track A display
          Text('Track A: ${widget.data['fileA']}'),
          const SizedBox(height: 10),
          Container(
            height: 50,
            color: Colors.grey[300],
            alignment: Alignment.center,
            child: const Text('Player A Waveform'),
          ),

          const SizedBox(height: 20),

          // Track B display
          Text('Track B: ${widget.data['fileB']}'),
          const SizedBox(height: 10),
          Container(
            height: 50,
            color: Colors.grey[300],
            alignment: Alignment.center,
            child: const Text('Player B Waveform'),
          ),

          const SizedBox(height: 30),
          const Text('Jog Wheel Control', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),

          // Jog wheel UI
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 40,
                icon: const Icon(Icons.arrow_left),
                onPressed: () {
                  playerB.seek(playerB.position - const Duration(milliseconds: 10));
                },
              ),
              const SizedBox(width: 40),
              IconButton(
                iconSize: 40,
                icon: const Icon(Icons.arrow_right),
                onPressed: () {
                  playerB.seek(playerB.position + const Duration(milliseconds: 10));
                },
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Playback button
          ElevatedButton.icon(
            icon: const Icon(Icons.play_arrow),
            label: const Text('Start Looping Playback'),
            onPressed: () async {
              try {
                await Future.wait([playerA.seek(Duration.zero), playerB.seek(Duration.zero)]);
                await Future.wait([playerA.play(), playerB.play()]);
              } catch (e) {
                print('❌ Error starting playback: $e');
              }
            },
          ),

          const SizedBox(height: 20),

          // Validation button
          ElevatedButton.icon(
            icon: const Icon(Icons.check),
            label: const Text('Validate Sync'),
            onPressed: () async {
              await playerA.stop();
              await playerB.stop();

              final toleranceMs = widget.data['toleranceMs'] ?? 50;
              final offset = playerA.position.inMilliseconds - playerB.position.inMilliseconds;
              final isCorrect = offset.abs() <= toleranceMs;

              setState(() {
                _hasValidated = true;
                _isCorrect = isCorrect;
                _offsetMs = offset;
                if (_isCorrect) {
                  _BeatmatchPageState._correctAnswers++;
                } else {
                  _BeatmatchPageState._incorrectAnswers++;
                }
              });

              widget.onValidated?.call(_isCorrect);
            },
          ),

          // Feedback UI
          if (_hasValidated)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                _isCorrect ? "Correct answer ✅" : "Incorrect answer ❌",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _isCorrect ? Colors.green : Colors.red,
                ),
              ),
            ),
        ],
      ),
    );
  }
}