import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class BeatmatchPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const BeatmatchPage({super.key, required this.data});

  @override
  State<BeatmatchPage> createState() => _BeatmatchPageState();
}

class _BeatmatchPageState extends State<BeatmatchPage> {
  late AudioPlayer playerA;
  late AudioPlayer playerB;

  @override
  void initState() {
    super.initState();
    playerA = AudioPlayer();
    playerB = AudioPlayer();

    playerA.playerStateStream.listen((state) {
      print("🎧 playerA → ${state.processingState}, playing: ${state.playing}");
    });
    playerB.playerStateStream.listen((state) {
      print("🎧 playerB → ${state.processingState}, playing: ${state.playing}");
    });

    _loadAudio();
  }

  Future<void> _loadAudio() async {
    try {
      final fileA = widget.data['fileA'];
      final fileB = widget.data['fileB'];
      final initialOffset = widget.data['initialOffsetMs'] ?? 0;

      print('🎧 fileA: $fileA, fileB: $fileB');

      if (fileA == null || fileB == null) {
        print('❌ Fichier audio manquant');
        return;
      }

      final urlA = 'http://localhost:18080/audio-files/$fileA';
      final urlB = 'http://localhost:18080/audio-files/$fileB';

      print('🔗 playerA URL: $urlA');
      print('🔗 playerB URL: $urlB');

      await playerA.setUrl(urlA);
      print('✅ playerA ready');

      final resultB = await playerB.setUrl(urlB);
      if (resultB == null) {
        print('❌ Le chargement de playerB a échoué');
      } else {
        print('✅ playerB ready with duration: $resultB');
        await playerB.seek(Duration(milliseconds: initialOffset));
        print('⏩ Seeked playerB to $initialOffset ms');
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
    return Column(
      children: [
        const Text(
          '🔊 Beatmatch Exercise',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text('A: ${widget.data['fileA']} | B: ${widget.data['fileB']}'),
        const SizedBox(height: 20),
        const Text('Use the arrows to adjust the track B until it syncs.'),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            try {
              await playerA.play();
              await playerB.play();
              print('▶️ Both players started');
            } catch (e) {
              print('❌ Error starting playback: $e');
            }
          },
          child: const Text('Play Both Tracks'),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.fast_rewind),
              onPressed: () {
                playerB.seek(playerB.position - const Duration(milliseconds: 100));
              },
            ),
            const SizedBox(width: 20),
            IconButton(
              icon: const Icon(Icons.fast_forward),
              onPressed: () {
                playerB.seek(playerB.position + const Duration(milliseconds: 100));
              },
            ),
          ],
        ),
      ],
    );
  }
}