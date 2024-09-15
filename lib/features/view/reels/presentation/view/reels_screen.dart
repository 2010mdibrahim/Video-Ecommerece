import 'dart:async'; // Import Timer

import 'package:e_commerce/core/di/app_component.dart';
import 'package:e_commerce/features/view/reels/presentation/controller/reels_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  VideoPlayerController? _controller;
  int _currentPage = 0;
  final PageController _pageController = PageController();
  var controller = locator<ReelsController>();
  Duration _videoDuration = Duration.zero;
  Duration _currentPosition = Duration.zero;
  bool _isPlaying = false;
  bool _hasApiCallTriggered = false;

  // Add these variables
  bool _controlsVisible = false;
  Timer? _hideControlsTimer;

  @override
  void initState() {
    super.initState();
    if (controller.reelsModel.value.data?.isNotEmpty == true) {
      final initialUrl =
          "http://erp.mahfuza-overseas.com/trending-house/${controller.reelsModel.value.data?[0].videoUrl ?? ''}";
      _initController(initialUrl, controller.reelsModel.value.data?[0].id);
    }
  }

  void _initController(String link, int? id) {
    _controller = VideoPlayerController.network(link)
      ..addListener(() {
        setState(() {
          _videoDuration = _controller?.value.duration ?? Duration.zero;
          _currentPosition = _controller?.value.position ?? Duration.zero;
          _isPlaying = _controller?.value.isPlaying ?? false;

          final percentageWatched = _calculatePercentageWatched();
          if (percentageWatched >= 80 && !_hasApiCallTriggered) {
            _callApi(id);
            _hasApiCallTriggered = true;
          }

          if (_controller?.value.position == _controller?.value.duration) {
            _controller?.pause();
            _isPlaying = false;
          }
        });
      })
      ..initialize().then((_) {
        setState(() {
          _videoDuration = _controller?.value.duration ?? Duration.zero;
          _currentPosition = _controller?.value.position ?? Duration.zero;
          _isPlaying = _controller?.value.isPlaying ?? false;
          _controller?.play();
        });
      }).catchError((error) {
        print("Error initializing video: $error");
      });
  }

  Future<void> _onControllerChange(String link, param1) async {
    if (_controller != null) {
      final oldController = _controller;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await oldController?.dispose();
        _initController(link, param1);
      });
      setState(() {
        _controller = null;
        _videoDuration = Duration.zero;
        _currentPosition = Duration.zero;
        _isPlaying = false;
        _hasApiCallTriggered = false;
      });
    } else {
      _initController(link, param1);
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
      final videoData = controller.reelsModel.value.data?[index].videoUrl ?? '';
      final id = controller.reelsModel.value.data?[index].id;
      final videoUrl =
          "http://erp.mahfuza-overseas.com/trending-house/$videoData";
      _onControllerChange(videoUrl, id);
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _hideControlsTimer?.cancel();
    super.dispose();
  }

  double _calculatePercentageWatched() {
    if (_videoDuration.inSeconds > 0) {
      return (_currentPosition.inSeconds / _videoDuration.inSeconds) * 100;
    }
    return 0.0;
  }

  Future<void> _callApi(int? id) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://erp.mahfuza-overseas.com/trending-house/api/watch-history'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: {"video_id": id.toString()},
      );

      if (response.statusCode == 200) {
        print('API call successful: ${response.body}');
      } else {
        print('API call failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error making API call: $e');
    }
  }

  // Handle tap to show and hide controls
  void _onTap() {
    setState(() {
      _controlsVisible = true;
      _hideControlsTimer?.cancel(); // Cancel any existing timer
      _hideControlsTimer = Timer(Duration(seconds: 3), () {
        setState(() {
          _controlsVisible = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final percentageWatched = _calculatePercentageWatched();

    return GetBuilder(
        init: ReelsController(),
        builder: (context) {
          return Obx(() => Scaffold(
                backgroundColor: Colors.black,
                body: GestureDetector(
                  onTap: _onTap, // Detect taps to show controls
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    onPageChanged: _onPageChanged,
                    itemCount: controller.reelsModel.value.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final videoData =
                          controller.reelsModel.value.data?[index];

                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          if (_controller != null &&
                              _controller!.value.isInitialized)
                            AspectRatio(
                              aspectRatio: _controller!.value.aspectRatio,
                              child: VideoPlayer(_controller!),
                            )
                          else
                            Center(child: CircularProgressIndicator()),
                          if (_controlsVisible)
                            Positioned(
                              bottom: 10,
                              left: 0,
                              right: 0,
                              child: AnimatedOpacity(
                                opacity: _controlsVisible ? 1.0 : 0.0,
                                duration: Duration(milliseconds: 300),
                                child: SliderTheme(
                                  data: SliderThemeData(
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 6),
                                    overlayShape: RoundSliderOverlayShape(
                                        overlayRadius: 16),
                                    trackHeight: 1.9,
                                  ),
                                  child: Slider(
                                    value:
                                        _currentPosition.inSeconds.toDouble(),
                                    min: 0.0,
                                    max: _videoDuration.inSeconds.toDouble(),
                                    activeColor: Colors.white,
                                    inactiveColor: Colors.grey,
                                    onChanged: (value) {
                                      setState(() {
                                        _controller?.seekTo(
                                            Duration(seconds: value.toInt()));
                                        // Keep controls visible while user interacts
                                        _onTap();
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          if (_controlsVisible)
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              top: 0,
                              child: AnimatedOpacity(
                                opacity: _controlsVisible ? 1.0 : 0.0,
                                duration: Duration(milliseconds: 300),
                                child: Center(
                                  child: IconButton(
                                    icon: Icon(
                                      _isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      size: 70,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (_isPlaying) {
                                          _controller?.pause();
                                          _isPlaying = false;
                                        } else {
                                          _controller?.play();
                                          _isPlaying = true;
                                        }
                                      });
                                      _onTap(); // Keep controls visible when user interacts
                                    },
                                  ),
                                ),
                              ),
                            ),

                        ],
                      );
                    },
                  ),
                ),
              ));
        });
  }
}
