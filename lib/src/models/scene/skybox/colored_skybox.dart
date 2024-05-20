import 'package:playx_3d_scene/src/models/scene/skybox/skybox.dart';
import 'package:playx_3d_scene/src/utils/utils.dart';

/// An object that represents skybox based that shows a color only.
class ColoredSkybox extends Skybox {
  ColoredSkybox({required super.color});

  @override
  Map<String, dynamic> toJson() => {
        'assetPath': assetPath,
        'url': url,
        'color': color?.toHex(),
        'skyboxType': 3
      };

  @override
  String toString() {
    return 'ColoredSkybox(assetPath: $assetPath, url: $url, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ColoredSkybox &&
        other.assetPath == assetPath &&
        other.url == url &&
        other.color == color;
  }

  @override
  int get hashCode => assetPath.hashCode ^ url.hashCode ^ color.hashCode;
}
