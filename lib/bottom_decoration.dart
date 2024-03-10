import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BottomDecoration extends SpriteComponent with CollisionCallbacks {
  BottomDecoration({required this.startingPosition})
      : super(scale: Vector2(.5, .5));

  final Vector2 startingPosition;
  late ShapeHitbox hitbox;

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('ground.png');
    position = startingPosition;
    anchor = Anchor.bottomCenter;

    final defaultPaint = Paint()
      ..color = const Color.fromARGB(135, 255, 86, 86)
      ..style = PaintingStyle.fill;

    Vector2 startingPos = Vector2(100, 60);
    Vector2 startingSize = sprite!.srcSize;

    hitbox = PolygonHitbox([
      startingPos,
      startingPos + Vector2(startingSize.x / 2, startingSize.y / 4),
      startingPos +
          Vector2(startingSize.x / 2, startingSize.y + startingSize.y / 2),
      startingPos + Vector2(0, startingSize.y),
    ])
      ..paint = defaultPaint
      ..collisionType = CollisionType.passive
      ..renderShape = true;

    add(hitbox);
  }
}
