import 'package:block_stack_3d/game_loop.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setPortraitUpOnly();

  GameLoop game = GameLoop();
  runApp(GameWidget(
    game: kDebugMode ? GameLoop() : game,
    backgroundBuilder: (context) {
      return Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xFF058bde), Color(0xFFe0f0fa)],
              ),
            ),
          ),
        ],
      );
    },
  ));
}
