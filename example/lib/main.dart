import 'package:flutter/material.dart';
import 'package:playx_3d_scene/playx_3d_scene.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isModelLoading = false;
  bool isSceneLoading = false;
  bool isShapeLoading = false;
  late Playx3dSceneController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Playx3dScene(
              model: GlbModel.asset(
                "assets/models/Fox.glb",
                animation: PlayxAnimation.byIndex(0, autoPlay: true),
                fallback: GlbModel.asset("assets/models/Fox.glb"),
                centerPosition: PlayxPosition(x: 0, y: 0, z: -4),
                scale: 1.0,
              ),
              scene: Scene(
                skybox: HdrSkybox.asset("assets/envs/courtyard.hdr"),
                indirectLight:
                    HdrIndirectLight.asset("assets/envs/courtyard.hdr"),
                light: Light(
                    type: LightType.directional,
                    colorTemperature: 6500,
                    intensity: 10000,
                    castShadows: false,
                    castLight: true,
                    position: PlayxPosition(x: -1, y: 0, z: 0),
                    direction: PlayxDirection(x: -1, y: -1, z: 0)),
                ground: Ground(
                  width: 4.0,
                  height: 4.0,
                  isBelowModel: true,
                  normal: PlayxDirection.y(1.0),
                  material: PlayxMaterial.asset(
                    "assets/materials/textured_pbr.filamat",
                    parameters: [
                      MaterialParameter.texture(
                        value: PlayxTexture.asset(
                          "assets/materials/texture/floor_basecolor.png",
                          type: TextureType.color,
                          sampler: PlayxTextureSampler(anisotropy: 8),
                        ),
                        name: "baseColor",
                      ),
                      MaterialParameter.texture(
                        value: PlayxTexture.asset(
                          "assets/materials/texture/floor_normal.png",
                          type: TextureType.normal,
                          sampler: PlayxTextureSampler(anisotropy: 8),
                        ),
                        name: "normal",
                      ),
                      MaterialParameter.texture(
                        value: PlayxTexture.asset(
                          "assets/materials/texture/floor_ao_roughness_metallic.png",
                          type: TextureType.data,
                          sampler: PlayxTextureSampler(anisotropy: 8),
                        ),
                        name: "aoRoughnessMetallic",
                      ),
                    ],
                  ),
                ),
                camera: Camera.orbit(
                  exposure: Exposure.formAperture(
                    aperture: 16.0,
                    shutterSpeed: 1 / 125,
                    sensitivity: 150,
                  ),
                  targetPosition: PlayxPosition(x: 0.0, y: 0.0, z: -4.0),
                  orbitHomePosition: PlayxPosition(x: 0.0, y: 1.0, z: 1.0),
                  upVector: PlayxPosition(x: 0.0, y: 1.0, z: 0.0),
                ),
              ),
              shapes: [
                Cube(
                  id: 1,
                  length: .5,
                  centerPosition: PlayxPosition(x: -1, y: 0, z: -4),
                  material: PlayxMaterial.asset(
                    "assets/materials/textured_pbr.filamat",
                    parameters: [
                      MaterialParameter.texture(
                        value: PlayxTexture.asset(
                          "assets/materials/texture/floor_basecolor.png",
                          type: TextureType.color,
                          sampler: PlayxTextureSampler(anisotropy: 8),
                        ),
                        name: "baseColor",
                      ),
                      MaterialParameter.texture(
                        value: PlayxTexture.asset(
                          "assets/materials/texture/floor_normal.png",
                          type: TextureType.normal,
                          sampler: PlayxTextureSampler(anisotropy: 8),
                        ),
                        name: "normal",
                      ),
                      MaterialParameter.texture(
                        value: PlayxTexture.asset(
                          "assets/materials/texture/floor_ao_roughness_metallic.png",
                          type: TextureType.data,
                          sampler: PlayxTextureSampler(anisotropy: 8),
                        ),
                        name: "aoRoughnessMetallic",
                      ),
                    ],
                  ),
                ),
                Sphere(
                  id: 2,
                  centerPosition: PlayxPosition(x: 1, y: 0, z: -4),
                  radius: .5,
                  material: PlayxMaterial.asset(
                    "assets/materials/textured_pbr.filamat",
                    parameters: [
                      MaterialParameter.texture(
                        value: PlayxTexture.asset(
                          "assets/materials/texture/floor_basecolor.png",
                          type: TextureType.color,
                          sampler: PlayxTextureSampler(anisotropy: 8),
                        ),
                        name: "baseColor",
                      ),
                      MaterialParameter.texture(
                        value: PlayxTexture.asset(
                          "assets/materials/texture/floor_normal.png",
                          type: TextureType.normal,
                          sampler: PlayxTextureSampler(anisotropy: 8),
                        ),
                        name: "normal",
                      ),
                      MaterialParameter.texture(
                        value: PlayxTexture.asset(
                          "assets/materials/texture/floor_ao_roughness_metallic.png",
                          type: TextureType.data,
                          sampler: PlayxTextureSampler(anisotropy: 8),
                        ),
                        name: "aoRoughnessMetallic",
                      ),
                    ],
                  ),
                )
              ],
              onCreated: (Playx3dSceneController controller) async {
                Future.delayed(const Duration(seconds: 5), () async {
                  Result<int?> result =
                      await controller.changeAnimationByIndex(1);

                  if (result.isSuccess()) {
                    final data = result.data;
                    print("success :$data");
                  } else {
                    print(result.message);
                  }
                });
              },
              onModelStateChanged: (state) {
                print('Playx3dSceneController: onModelStateChanged: $state');
                setState(() {
                  isModelLoading = state == ModelState.loading;
                });
              },
              onSceneStateChanged: (state) {
                print('Playx3dSceneController: onSceneStateChanged: $state');
                setState(() {
                  isSceneLoading = state == SceneState.loading;
                });
              },
              onShapeStateChanged: (state) {
                print('Playx3dSceneController: onShapeStateChanged: $state');
                setState(() {
                  isShapeLoading = state == ShapeState.loading;
                });
              },
              onEachRender: (frameTimeNano) {},
            ),
            isModelLoading || isSceneLoading || isShapeLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.pink,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
