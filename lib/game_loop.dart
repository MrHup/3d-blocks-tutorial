import 'package:block_stack_3d/bottom_decoration.dart';
import 'package:block_stack_3d/box_stack.dart';
import 'package:block_stack_3d/falling_box.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class GameLoop extends FlameGame with TapCallbacks, HasCollisionDetection {
  late BoxStack boxStack;
  @override
  Future<void> onLoad() async {
    BottomDecoration bottomDecoration =
        BottomDecoration(startingPosition: Vector2(size.x / 2, size.y));
    add(bottomDecoration);

    boxStack = BoxStack(Vector2(size.x, size.y));
    add(boxStack);
  }

  @override
  void onTapDown(TapDownEvent event) {
    FallingBox box = FallingBox(
      imgPath: 'player.png',
      startingPosition: event.localPosition,
      positionCollisionBox: Vector2(0, 60),
    );
    boxStack.add(box);
    boxStack.players.add(box);
  }
}
