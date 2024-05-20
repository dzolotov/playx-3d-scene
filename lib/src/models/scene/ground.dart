import 'package:playx_3d_scene/src/models/scene/geometry/size.dart';
import 'package:playx_3d_scene/src/models/shapes/plane.dart';

///An object that represents ground plane to be drawn on the scene.
class Ground extends Plane {
  /// width of the ground plane.
  double width;

  /// height of the ground plane.
  double height;

  /// Whether the ground plane should be drawn below the model or not.
  bool isBelowModel = true;

  Ground(
      {required this.width,
      required this.height,
      super.centerPosition,
      super.normal,
      this.isBelowModel = false,
      super.material})
      : super(size: PlayxSize(x: width, z: height), id: 0);

  @override
  Map<String, dynamic> toJson() => {
        'centerPosition': centerPosition?.toJson(),
        'normal': normal?.toJson(),
        'isBelowModel': isBelowModel,
        'size': size.toJson(),
        'material': material?.toJson(),
      };

  @override
  String toString() {
    return 'Ground(width: $width, height: $height, isBelowModel: $isBelowModel)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ground &&
        other.centerPosition == centerPosition &&
        other.normal == normal &&
        other.isBelowModel == isBelowModel &&
        other.size == size &&
        other.material == material;
  }

  @override
  int get hashCode =>
      centerPosition.hashCode ^
      normal.hashCode ^
      isBelowModel.hashCode ^
      size.hashCode ^
      material.hashCode;
}
