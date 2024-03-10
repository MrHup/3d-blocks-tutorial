import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class FallingBox extends SpriteComponent with CollisionCallbacks {
  FallingBox(
      {required this.imgPath,
      required this.startingPosition,
      required this.positionCollisionBox,
      this.collisionBox})
      : super(scale: Vector2(.5, .5));

  final String imgPath;
  final Vector2? collisionBox;
  final Vector2 startingPosition;
  Vector2 positionCollisionBox;

  late ShapeHitbox hitbox;

  static const double SPEED = 100;
  double acceleration = 1;
  bool isFalling = true;

  @override
  Future<void> onLoad() async {
    print("Loaded");
    sprite = await Sprite.load(imgPath);
    position = startingPosition;
    anchor = Anchor.center;

    final defaultPaint = Paint()
      ..color = const Color.fromARGB(135, 255, 86, 86)
      ..style = PaintingStyle.fill;

    // make parallelogram hitbox
    Vector2 startingPos = positionCollisionBox;
    Vector2 startingSize = collisionBox ?? sprite!.srcSize;

    hitbox = PolygonHitbox([
      startingPos,
      startingPos + Vector2(startingSize.x / 2, startingSize.y / 4),
      startingPos +
          Vector2(startingSize.x / 2, startingSize.y - startingSize.y / 4),
      startingPos + Vector2(0, startingSize.y - startingSize.y / 2),
    ])
      ..paint = defaultPaint
      ..renderShape = true;

    add(hitbox);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!isFalling) return;

    position += Vector2(0, 2) * dt * SPEED * acceleration;
    acceleration += 0.02 * dt * SPEED + 0.0002 * dt * SPEED * SPEED;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    setToPassive();
    super.onCollision(intersectionPoints, other);
  }

  void setToPassive() {
    hitbox.collisionType = CollisionType.passive;
    isFalling = false;
  }
}
