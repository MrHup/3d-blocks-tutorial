import 'package:block_stack_3d/falling_box.dart';
import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';

class BoxStack extends PositionComponent {
  BoxStack(Vector2 size)
      : super(
          size: size,
          position: Vector2(0, 0),
        );

  List<FallingBox> players = [];

  @override
  void render(Canvas canvas) {
    sortPlayers();
    for (var element in players) {
      element.parent = this;
    }
    super.render(canvas);
  }

  bool isOverlap(FallingBox A, FallingBox B) {
    if (B.hitbox.absolutePosition.x + B.hitbox.absoluteScaledSize.x <
            A.hitbox.absolutePosition.x ||
        A.hitbox.absolutePosition.x + A.hitbox.absoluteScaledSize.x <
            B.hitbox.absolutePosition.x) {
      return false;
    }
    return true;
  }

  int shouldLower(FallingBox A, FallingBox B) {
    final x1 = A.hitbox.absolutePosition.x;
    final y1 = A.hitbox.absolutePosition.y;
    final x2 = B.hitbox.absolutePosition.x;
    final y2 = B.hitbox.absolutePosition.y;
    if (isOverlap(A, B)) {
      if (y1 < y2 && x1 < x2) {
        return 1;
      } else if (y1 == y2 && x1 < x2) {
        return 1;
      } else if (y1 < y2 && x1 == x2) {
        return 1;
      } else if (y1 == y2 && x1 == x2) {
        return 1;
      } else if (y1 < y2 && x1 > x2) {
        return 1;
      }
      return -1;
    } else {
      if (y1 < y2 && x1 < x2) {
        return -1;
      } else if (y1 == y2 && x1 < x2) {
        return -1;
      } else if (y1 > y2 && x1 < x2) {
        return -1;
      }
      return 1;
    }
  }

  void sortPlayers() {
    players.sort((a, b) => shouldLower(a, b));
  }
}
