import 'dart:async'; // Import Timer

import 'package:e_commerce/core/core/extensions/extensions.dart';
import 'package:e_commerce/core/di/app_component.dart';
import 'package:e_commerce/core/utils/app_assets.dart';
import 'package:e_commerce/features/view/reels/data/model/reels_model.dart';
import 'package:e_commerce/features/view/reels/presentation/controller/reels_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/utils/appStyle.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_sizes.dart';
import '../../../../widget/cached_image_network/custom_cached_image_network.dart';
import '../../../../widget/custom_elevatedButton/custom_eleveted_button.dart';
import '../../../../widget/custom_textfield/custom_textfield.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> with WidgetsBindingObserver {
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
    WidgetsBinding.instance.addObserver(this);
    if (controller.reelsModel.value.data?.isNotEmpty == true) {
      print(
          "controller.indexFromMyVideo.value ${controller.indexFromMyVideo.value}");
      final initialUrl =
          "http://erp.mahfuza-overseas.com/trending-house/${controller.reelsModel.value.data?[controller.indexFromMyVideo.value].videoUrl ?? ''}";
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
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    _hideControlsTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _controller?.pause();
      setState(() {
        _isPlaying = false;
      });
    } else if (state == AppLifecycleState.resumed) {
      // Optionally handle resuming the video if needed
      WidgetsBinding.instance.removeObserver(this);
      _controller?.dispose();
      _hideControlsTimer?.cancel();
    }
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
      _hideControlsTimer = Timer(const Duration(seconds: 3), () {
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
        builder: (controller) {
          return Obx(() => Scaffold(
                backgroundColor: Colors.black,
                body: PopScope(
                  canPop: true,
                  onPopInvoked: (bool didPop) {
                    if (didPop) {
                      return;
                    }
                    setState(() {
                      Navigator.pop(context);
                      _controller?.dispose();
                      _hideControlsTimer?.cancel();
                    });
                  },
                  child: GestureDetector(
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
                              const Center(child: CircularProgressIndicator()),
                            if (_controlsVisible)
                              Positioned(
                                bottom: 10,
                                left: 0,
                                right: 0,
                                child: AnimatedOpacity(
                                  opacity: _controlsVisible ? 1.0 : 0.0,
                                  duration: const Duration(milliseconds: 300),
                                  child: SliderTheme(
                                    data: const SliderThemeData(
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
                                  duration: const Duration(milliseconds: 300),
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

                            // like share comment view

                            Positioned(
                              right: 0,
                              bottom: 80,
                              child: Column(
                                children: [
                                  CustomButtonLikeShareComment(
                                      icon: videoData?.likeStatus == 0
                                          ? AppAssets.likeNotDone
                                          : AppAssets.likeDone,
                                      onPress: () {
                                        controller
                                            .likeVideos(
                                                likeValue: videoData?.likeStatus == 0
                                                    ? 1
                                                    : 0,
                                                videoId: videoData?.id ?? 0)
                                            .then((value) {
                                          videoData?.likeStatus =
                                              videoData?.likeStatus == 0 ? 1 : 0;
                                        });
                                      }),
                                  CustomButtonLikeShareComment(
                                      icon: AppAssets.commentsIcon,
                                      onPress: () {}),
                                  CustomButtonLikeShareComment(
                                      icon: AppAssets.share, onPress: () {}),
                                  CustomButtonLikeShareComment(
                                      icon: '',
                                      onPress: () {},
                                      icons: const Icon(
                                        Icons.remove_red_eye_outlined,
                                        size: 23,
                                      )),
                                  CustomButtonLikeShareComment(
                                      icon: '',
                                      onPress: () {},
                                      icons: const Icon(
                                        Icons.shopping_cart,
                                        size: 23,
                                      )),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 40,
                              child: CustomElevatedButton(
                                hexColor: Colors.white,
                                textColor: Colors.black,
                                fontWeight: FontWeight.bold,
                                text: "Order Now",
                                topRightRadius: 5,
                                bottomLeftRadius: 5,
                                topLeft: 5,
                                bottomRight: 5,
                                onPress: () {
                                  confirmationDialog(context, videoData);
                                  controller.priceSum.value =
                                      controller.price.value;
                                  // RouteGenerator.pushNamed(context, Routes.homepage);
                                },
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ));
        });
  }

  Widget CustomButtonLikeShareComment(
      {required String icon, required VoidCallback onPress, Icon? icons}) {
    //{required Icon icon, required VoidCallback onPress}
    return IconButton(
      onPressed: onPress,
      icon: icon.isNotEmpty
          ? Image.asset(
              icon,
              height: 25,
              width: 30,
              fit: BoxFit.cover,
            )
          : (icons ?? const SizedBox()),
      color: Colors.white,
    );
  }

  Widget CustomContainer({required String value}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.deepGrey),
          color: Colors.transparent),
      child: Center(
        child: CustomSimpleText(
          text: value,
          fontWeight: FontWeight.bold,
          fontSize: AppSizes.size12,
          color: AppColors.black,
          alignment: Alignment.bottomCenter,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget CustomRow({required String title, required String price}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSimpleText(
          text: title,
          fontWeight: FontWeight.bold,
          fontSize: AppSizes.size13,
          color: AppColors.black,
          alignment: Alignment.centerLeft,
          textAlign: TextAlign.start,
        ),
        CustomSimpleText(
          text: price,
          fontWeight: FontWeight.bold,
          fontSize: AppSizes.size13,
          color: AppColors.black,
          alignment: Alignment.centerRight,
          textAlign: TextAlign.end,
        ),
      ],
    );
  }

  Future<void> confirmationDialog(BuildContext context, Data? videoData) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomSimpleText(
                text: "Purchase",
                fontWeight: FontWeight.bold,
                fontSize: AppSizes.size18,
                color: AppColors.black,
              ),
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        if (controller.orderNumber.value > 1) {
                          controller.orderNumber.value--;
                          controller.priceSum.value -= controller.price.value;
                        }
                      },
                      child: CustomContainer(value: "-")),
                  5.pw,
                  Obx(
                    () => CustomContainer(
                        value: "${controller.orderNumber.value}"),
                  ),
                  5.pw,
                  InkWell(
                      onTap: () {
                        controller.orderNumber.value++;
                        controller.priceSum.value += controller.price.value;
                      },
                      child: CustomContainer(value: "+")),
                ],
              )
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CustomCachedImageNetwork(
                            imageUrl:
                                "http://erp.mahfuza-overseas.com/trending-house/${videoData?.thumbnail}",
                            height: 100,
                            weight:
                                100, // Correct typo from "weight" to "width"
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: CustomSimpleText(
                            text: "CNG Product",
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.size14,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                      width: 10), // Add some spacing between the two columns
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomSimpleText(
                          text: "Price Details",
                          fontWeight: FontWeight.bold,
                          fontSize: AppSizes.size16,
                          color: AppColors.black,
                        ),
                        Obx(
                          () => CustomRow(
                              title: "Total MRP",
                              price: "৳${controller.price.value}"),
                        ),
                        CustomRow(title: "Discount", price: "৳5"),
                        CustomRow(title: "Tax", price: "৳3"),
                        Divider(
                          color: AppColors.backgroundColor,
                        ),
                        Obx(
                          () => CustomRow(
                              title: "Total ",
                              price: "৳${controller.priceSum.value + 5 + 3}"),
                        ),
                        10.ph,
                        CustomSimpleText(
                          text: "HAVE A PROMOTION CODE?",
                          fontWeight: FontWeight.bold,
                          fontSize: AppSizes.size12,
                          color: AppColors.black,
                          textDecoration: TextDecoration.underline,
                        ),
                        10.ph,
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            billingDetails(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.backgroundColor),
                            child: CustomSimpleText(
                              text: "Place Order",
                              fontWeight: FontWeight.bold,
                              fontSize: AppSizes.size14,
                              color: AppColors.white,
                              textDecoration: TextDecoration.underline,
                              alignment: Alignment.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              20.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSimpleText(
                    text: "Content Creator will get bonus",
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.size14,
                    color: AppColors.black,
                    textDecoration: TextDecoration.none,
                    alignment: Alignment.center,
                    textAlign: TextAlign.center,
                  ),
                  10.pw,
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ))
                ],
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Less curved corners
          ),
        );
      },
    );
  }

  Future<void> billingDetails(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          backgroundColor: Colors.white,
          title: CustomSimpleText(
            text: "Billing Details",
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.size18,
            color: AppColors.black,
          ),
          content: SizedBox( // Constrain the width
            width: MediaQuery.of(context).size.width ,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: CustomTextfield(
                          controller: controller.fullNameController.value,
                          hintText: "Full Name",
                          lebelText: "Full Name",
                          labelLeftPadding: 14,
                        ),
                      ),
                    ),
                    10.pw,
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: CustomTextfield(
                          controller: controller.phoneNumberController.value,
                          hintText: "Phone Number",
                          lebelText: "Phone Number",
                          labelLeftPadding: 14,
                          textInputType: TextInputType.number,
                        ),
                      ),
                    ),
                  ],
                ),
                15.ph,
                SizedBox(
                  height: 45,
                  child: CustomTextfield(
                    controller: controller.detailAddressController.value,
                    hintText: "Details Address",
                    lebelText: "Details Address",
                    labelLeftPadding: 14,
                  ),
                ),

                CustomSimpleText(
                  text: "Price Details",
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.size17,
                  color: AppColors.black,
                ),
                10.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomSimpleText(
                      text: "Total MRP",
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizes.size13,
                      color: AppColors.black,
                    ),
                    CustomSimpleText(
                      text: controller.priceSum.value.toString(),
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizes.size13,
                      color: AppColors.black,
                    ),
                  ],
                )
                // Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     Flexible(
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //           ClipRRect(
                //             borderRadius: BorderRadius.circular(10),
                //             child: CustomCachedImageNetwork(
                //               imageUrl:
                //               "http://erp.mahfuza-overseas.com/trending-house/${videoData?.thumbnail}",
                //               height: 100,
                //               weight:
                //               100, // Correct typo from "weight" to "width"
                //             ),
                //           ),
                //           const SizedBox(height: 10),
                //           Center(
                //             child: CustomSimpleText(
                //               text: "CNG Product",
                //               fontWeight: FontWeight.bold,
                //               fontSize: AppSizes.size14,
                //               color: AppColors.black,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     const SizedBox(
                //         width: 10), // Add some spacing between the two columns
                //     Flexible(
                //       flex: 2,
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //           CustomSimpleText(
                //             text: "Price Details",
                //             fontWeight: FontWeight.bold,
                //             fontSize: AppSizes.size16,
                //             color: AppColors.black,
                //           ),
                //           Obx(
                //                 () => CustomRow(
                //                 title: "Total MRP",
                //                 price: "৳${controller.price.value}"),
                //           ),
                //           CustomRow(title: "Discount", price: "৳5"),
                //           CustomRow(title: "Tax", price: "৳3"),
                //           Divider(
                //             color: AppColors.backgroundColor,
                //           ),
                //           Obx(
                //                 () => CustomRow(
                //                 title: "Total ",
                //                 price: "৳${controller.priceSum.value + 5 + 3}"),
                //           ),
                //           10.ph,
                //           CustomSimpleText(
                //             text: "HAVE A PROMOTION CODE?",
                //             fontWeight: FontWeight.bold,
                //             fontSize: AppSizes.size12,
                //             color: AppColors.black,
                //             textDecoration: TextDecoration.underline,
                //           ),
                //           10.ph,
                //           Container(
                //             padding: EdgeInsets.symmetric(vertical: 10),
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(10),
                //                 color: AppColors.backgroundColor),
                //             child: CustomSimpleText(
                //               text: "Place Order",
                //               fontWeight: FontWeight.bold,
                //               fontSize: AppSizes.size14,
                //               color: AppColors.white,
                //               textDecoration: TextDecoration.underline,
                //               alignment: Alignment.center,
                //             ),
                //           )
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                // 20.ph,
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     CustomSimpleText(
                //       text: "Content Creator will get bonus",
                //       fontWeight: FontWeight.bold,
                //       fontSize: AppSizes.size14,
                //       color: AppColors.black,
                //       textDecoration: TextDecoration.none,
                //       alignment: Alignment.center,
                //       textAlign: TextAlign.center,
                //     ),
                //     10.pw,
                //     IconButton(
                //         onPressed: () {},
                //         icon: Icon(
                //           Icons.arrow_forward_ios,
                //           size: 15,
                //         ))
                //   ],
                // ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Less curved corners
          ),
        );
      },
    );
  }
}
