import 'package:rive/src/generated/animation/listener_align_target_base.dart';
import 'package:rive/src/rive_core/constraints/constraint.dart';
import 'package:rive/src/rive_core/node.dart';
import 'package:rive/src/rive_core/state_machine_controller.dart';
import 'package:rive_common/math.dart';

export 'package:rive/src/generated/animation/listener_align_target_base.dart';

class ListenerAlignTarget extends ListenerAlignTargetBase {
  @override
  void perform(StateMachineController controller, Vec2D position,
      Vec2D previousPosition) {
    Node? target = controller.core.resolve(targetId);

    if (target == null) {
      return;
    }

    var targetParentWorld = parentWorld(target);
    var inverse = Mat2D();
    if (!Mat2D.invert(inverse, targetParentWorld)) {
      return;
    }

    if (preserveOffset) {
      var localPosition = inverse * position;
      var prevLocalPosition = inverse * previousPosition;
      target.x += localPosition.x - prevLocalPosition.x;
      target.y += localPosition.y - prevLocalPosition.y;
    } else {
      var localPosition = inverse * position;
      target.x = localPosition.x;
      target.y = localPosition.y;
    }
  }

  @override
  void targetIdChanged(int from, int to) {}

  @override
  void preserveOffsetChanged(bool from, bool to) {}
}
