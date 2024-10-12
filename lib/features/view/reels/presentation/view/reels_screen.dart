import 'dart:async'; // Import Timer
import 'dart:math';

import 'package:e_commerce/core/core/extensions/extensions.dart';
import 'package:e_commerce/core/di/app_component.dart';
import 'package:e_commerce/core/utils/app_assets.dart';
import 'package:e_commerce/features/view/reels/data/model/reels_model.dart';
import 'package:e_commerce/features/view/reels/presentation/controller/reels_controller.dart';
import 'package:e_commerce/features/widget/custom_richtext/custom_richtext.dart';
import 'package:e_commerce/features/widget/custom_toast/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../../../core/model/dropdown_model.dart';
import '../../../../../core/network/configuration.dart';
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
    WakelockPlus.enable();
    WidgetsBinding.instance.addObserver(this);
    if (controller.reelsModel.value.data?.isNotEmpty == true) {
      print("");


      Random random = Random();
      int randomNumber = random.nextInt(
          controller.reelsModel.value.data?.length ??
              0); // maxLength ensures it's positive
      controller.indexFromMyVideo.value = randomNumber;
      final initialUrl =
          "http://erp.mahfuza-overseas.com/trending-house/${controller.reelsModel.value.data?[controller.indexFromMyVideo.value ?? 1].videoUrl ?? ''}";
      _initController(
          initialUrl,
          controller
              .reelsModel.value.data?[controller.indexFromMyVideo.value ?? 1 ].id,
          controller
              .reelsModel.value.data
      );
    }
  }

  Future<void> _initController(String link, int? id, List<Data>? data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('addToCart');
    print("this is cart ${prefs.getString('cart')}");
    controller.creatorName.value = data?[controller.indexFromMyVideo.value].creatorName ??
        '';
    controller.productId.value = data?[controller.indexFromMyVideo.value].productId.toString() ?? '';
    controller.catName.value = data?[controller.indexFromMyVideo.value].catName ??
        '';
    controller.productName.value = data?[controller.indexFromMyVideo.value].productName ??
        '';
    controller.productPrice.value = controller
        .reelsModel.value.data?[controller.indexFromMyVideo.value].price
        .toString() ??
        "";
    controller.creatorPhoto.value = data?[controller.indexFromMyVideo.value].creatorPhoto ??
        "";
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

  Future<void> _onControllerChange(String link, param1, List<Data>? data) async {
    if (_controller != null) {
      final oldController = _controller;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await oldController?.dispose();
        _initController(link, param1, data);
      });
      setState(() {
        _controller = null;
        _videoDuration = Duration.zero;
        _currentPosition = Duration.zero;
        _isPlaying = false;
        _hasApiCallTriggered = false;
      });
    } else {
      _initController(link, param1,data);
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      print("This is index $index");
      _currentPage = index;
      final videoData = controller.reelsModel.value.data?[index].videoUrl ?? '';
      final id = controller.reelsModel.value.data?[index].id;
      final videoUrl =
          "http://erp.mahfuza-overseas.com/trending-house/$videoData";
      setState(() {
        controller.creatorName.value =
            controller.reelsModel.value.data?[index].creatorName ?? '';
        controller.catName.value =
            controller.reelsModel.value.data?[index].catName ?? '';
        controller.productName.value =
            controller.reelsModel.value.data?[index].productName ?? '';
        controller.productPrice.value =
            controller.reelsModel.value.data?[index].price.toString() ?? "";
        controller.creatorPhoto.value =
            controller.reelsModel.value.data?[index].creatorPhoto ?? "";
        controller.productId.value =  controller.reelsModel.value.data?[controller.indexFromMyVideo.value].productId.toString() ?? '';
      });
      _onControllerChange(videoUrl, id, controller.reelsModel.value.data);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    _hideControlsTimer?.cancel();
    WakelockPlus.disable();
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
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  actions: [
                    PopupMenuButton<DropdownModel>(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onSelected: (DropdownModel selectedValue) async {
                        await _controller?.dispose();

                        // Get the selected video ID and URL
                        int selectedVideoId = selectedValue.id; // Assume DropdownModel has an 'id' property
                        String selectedVideoUrl = controller.reelsModel.value.data?.firstWhere(
                        (video) => video.id == selectedVideoId,
                        orElse: () => Data(),
                        )?.videoUrl ?? ''; // Fetch the video URL based on the selected ID

                        // Check if the selected video URL is valid
                        if (selectedVideoUrl.isNotEmpty) {
                        await _initController(selectedVideoUrl, selectedVideoId, controller.reelsModel.value.data);
                        } else {
                        print("Selected video URL is empty");
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight:
                                    200, // Set the height of the dropdown
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: controller
                                      .allProductController.popupItemMenu
                                      .map((DropdownModel model) {
                                    return PopupMenuItem<DropdownModel>(
                                      value: model,
                                      child: Text(model.name),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ];
                      },
                    )
                  ],
                ),
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
                  child: controller.isLoading.value == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : controller.reelsModel.value.data?.isEmpty ?? false
                          ? const CustomSimpleText(
                              text: "No data available",
                              alignment: Alignment.center,
                              color: Colors.white,
                              fontSize: 18,
                            )
                          : GestureDetector(
                              onTap: _onTap, // Detect taps to show controls
                              child: PageView.builder(
                                controller: _pageController,
                                scrollDirection: Axis.vertical,
                                onPageChanged: _onPageChanged,
                                itemCount:
                                    controller.reelsModel.value.data?.length ??
                                        0,
                                itemBuilder: (context, index) {
                                  final videoData =
                                      controller.reelsModel.value.data?[index];
                                  print(
                                      "length ${controller.reelsModel.value.data?.length}");
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      if (_controller != null &&
                                          _controller!.value.isInitialized)
                                        AspectRatio(
                                          aspectRatio:
                                              _controller!.value.aspectRatio,
                                          child: VideoPlayer(_controller!),
                                        )
                                      else
                                        const Center(
                                            child: CircularProgressIndicator()),
                                      if (_controlsVisible)
                                        Positioned(
                                          bottom: 10,
                                          left: 0,
                                          right: 0,
                                          child: AnimatedOpacity(
                                            opacity:
                                                _controlsVisible ? 1.0 : 0.0,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            child: SliderTheme(
                                              data: const SliderThemeData(
                                                thumbShape:
                                                    RoundSliderThumbShape(
                                                        enabledThumbRadius: 6),
                                                overlayShape:
                                                    RoundSliderOverlayShape(
                                                        overlayRadius: 16),
                                                trackHeight: 1.9,
                                              ),
                                              child: Slider(
                                                value: _currentPosition
                                                    .inSeconds
                                                    .toDouble(),
                                                min: 0.0,
                                                max: _videoDuration.inSeconds
                                                    .toDouble(),
                                                activeColor: Colors.white,
                                                inactiveColor: Colors.grey,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _controller?.seekTo(
                                                        Duration(
                                                            seconds:
                                                                value.toInt()));
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
                                            opacity:
                                                _controlsVisible ? 1.0 : 0.0,
                                            duration: const Duration(
                                                milliseconds: 300),
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
                                        bottom: 110,
                                        child: Column(
                                          children: [
                                            CustomButtonLikeShareComment(
                                                icon: videoData?.likeStatus == 0
                                                    ? AppAssets.likeNotDone
                                                    : AppAssets.likeDone,
                                                onPress: () {
                                                  controller
                                                      .likeVideos(
                                                          likeValue: videoData
                                                                      ?.likeStatus ==
                                                                  0
                                                              ? 1
                                                              : 0,
                                                          videoId:
                                                              videoData?.id ??
                                                                  0)
                                                      .then((value) {
                                                    videoData?.likeStatus =
                                                        videoData?.likeStatus ==
                                                                0
                                                            ? 1
                                                            : 0;
                                                  });
                                                }),
                                            CustomButtonLikeShareComment(
                                                icon: AppAssets.commentsIcon,
                                                onPress: () {}),
                                            CustomButtonLikeShareComment(
                                                icon: AppAssets.share,
                                                onPress: () {}),
                                            CustomButtonLikeShareComment(
                                                icon: '',
                                                onPress: () {},
                                                icons: const Icon(
                                                  Icons.remove_red_eye_outlined,
                                                  size: 23,
                                                )),
                                            CustomButtonLikeShareComment(
                                                icon: '',
                                                onPress: () {
                                                  controller.addToCartFunction(
                                                      videoData?.productId
                                                              .toString() ??
                                                          '',
                                                      videoData,
                                                      videoData?.id);
                                                },
                                                icons: const Icon(
                                                  Icons.shopping_cart,
                                                  size: 23,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        bottom: 110,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: CustomCachedImageNetwork(
                                                    imageUrl:
                                                        "${NetworkConfiguration.baseUrl.replaceAll("api/", '')}assets/images/users/${controller.creatorPhoto.value}",
                                                    height: 40,
                                                    weight: 40),
                                              ),
                                              10.pw,
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomRichText(
                                                    title: controller
                                                        .creatorName.value,
                                                    titleTextColor:
                                                        Colors.white,
                                                    heading: "Creator Name: ",
                                                    headingTextColor: Colors
                                                        .white
                                                        .withOpacity(0.8),
                                                    headingFontSize:
                                                        AppSizes.size14,
                                                  ),
                                                  Visibility(
                                                    visible: controller.catName
                                                            .value.isEmpty
                                                        ? false
                                                        : true,
                                                    child: CustomRichText(
                                                      title: controller
                                                          .catName.value,
                                                      titleTextColor:
                                                          Colors.white,
                                                      heading:
                                                          "Product Category: ",
                                                      headingTextColor: Colors
                                                          .white
                                                          .withOpacity(0.8),
                                                      headingFontSize:
                                                          AppSizes.size14,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomSimpleText(
                                                        text: "Product Name: ",
                                                        color: Colors.white
                                                            .withOpacity(0.8),
                                                        fontSize:
                                                            AppSizes.size14,
                                                      ),
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                          child:
                                                              CustomSimpleText(
                                                            text: controller
                                                                .productName
                                                                .value,
                                                            color:
                                                                AppColors.white,
                                                            maxLines: 1,
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 40,
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 37,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.yellow),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: CustomSimpleText(
                                                    text:
                                                        "৳${controller.productPrice.value}"),
                                              ),
                                            ),
                                            20.pw,
                                            CustomElevatedButton(
                                              hexColor: Colors.white,
                                              textColor: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              text: "Order Now",
                                              topRightRadius: 5,
                                              bottomLeftRadius: 5,
                                              topLeft: 5,
                                              bottomRight: 5,
                                              onPress: () async {
                                                // SharedPreferences prefs = await SharedPreferences.getInstance();
                                                // prefs.remove("buyCart");
                                                print("product id ${controller.productId.value}");
                                                confirmationDialog(
                                                    context, videoData);
                                                controller.selectSizeColor
                                                    .value = '';
                                                controller.priceSum.value =
                                                    controller.price.value;

                                                // RouteGenerator.pushNamed(context, Routes.homepage);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Positioned(
                                      //   top: 0,
                                      //     right: 0,
                                      //     child:
                                      // )
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
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomSimpleText(
                              text: "QUANTITY",
                              textDecoration: TextDecoration.none,
                              alignment: Alignment.centerLeft,
                              textAlign: TextAlign.start,
                            ),
                            Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      if ((controller.quantity.value ) >
                                          1) {
                                        controller.decrementQuantity();
                                      }
                                    },
                                    child: CustomContainer(
                                        value:
                                        "-")),
                                5.pw,
                                Obx(()=> CustomSimpleText(text: "${controller.quantity.value}"),),
                                5.pw,
                                InkWell(
                                    onTap: () {
                                      controller.incrementQuantity();
                                    },
                                    child: CustomContainer(
                                        value:
                                        "+")),
                              ],
                            ),
                          ],
                        ),
                        (videoData?.size == null) ? SizedBox(
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: videoData?.size?.length ?? 0,
                            itemBuilder: (_, index) {
                              String item = videoData?.size?[index] ?? '';
                              return Obx(() => Row(
                                children: [
                                  Radio<String>(
                                    value: item,
                                    groupValue: controller.selectSize
                                        .value, // Make sure this is RxString
                                    onChanged: (String? value) {
                                      controller.selectSize.value = value!;
                                      controller.selectSizeId.value =
                                      index!;
                                      controller.selectSizePrice.value =
                                          controller.getCurrentPrice(
                                              data: videoData
                                                  ?.sizePrice) ??
                                              '';
                                      controller.selectSizeColor.value =
                                          controller.getCurrentColor(
                                              data: videoData?.color) ??
                                              '';
                                      controller.selectSizeQty.value =
                                          controller.getCurrentColor(
                                              data:
                                              videoData?.sizeQty) ??
                                              '';
                                      controller.selectSizeKey.value =
                                          index.toString();
                                      controller.totalMRP.value = int.parse(
                                          controller.getCurrentPrice(
                                              data: videoData
                                                  ?.sizePrice) ??
                                              '');
                                      print(
                                          "Selected size: ${controller.selectSize.value} ${controller.selectSizeColor.value} ${controller.selectSizeQty.value}");
                                    },
                                  ),
                                  CustomSimpleText(
                                    text: item, // "XL", "M", etc.
                                    textDecoration: TextDecoration.none,
                                    alignment: Alignment.center,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ));
                            },
                          ),
                        ) :  const CustomSimpleText(
                          text: "SIZE",
                          textDecoration: TextDecoration.none,
                          alignment: Alignment.centerLeft,
                          textAlign: TextAlign.start,
                        ),
                        // Wrap ListView.builder in SizedBox to give it a fixed height
                        (videoData?.size == null) ?  SizedBox.shrink() : SizedBox(
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: videoData?.size?.length ?? 0,
                            itemBuilder: (_, index) {
                              String item = videoData?.size?[index] ?? '';
                              return Obx(() => Row(
                                    children: [
                                      Radio<String>(
                                        value: item,
                                        groupValue: controller.selectSize
                                            .value, // Make sure this is RxString
                                        onChanged: (String? value) {
                                          controller.selectSize.value = value!;
                                          controller.selectSizeId.value =
                                              index!;
                                          controller.selectSizePrice.value =
                                              controller.getCurrentPrice(
                                                      data: videoData
                                                          ?.sizePrice) ??
                                                  '';
                                          controller.selectSizeColor.value =
                                              controller.getCurrentColor(
                                                      data: videoData?.color) ??
                                                  '';
                                          controller.selectSizeQty.value =
                                              controller.getCurrentColor(
                                                      data:
                                                          videoData?.sizeQty) ??
                                                  '';
                                          controller.selectSizeKey.value =
                                              index.toString();
                                          controller.totalMRP.value = int.parse(
                                              controller.getCurrentPrice(
                                                      data: videoData
                                                          ?.sizePrice) ??
                                                  '');
                                          print(
                                              "Selected size: ${controller.selectSize.value} ${controller.selectSizeColor.value} ${controller.selectSizeQty.value}");
                                        },
                                      ),
                                      CustomSimpleText(
                                        text: item, // "XL", "M", etc.
                                        textDecoration: TextDecoration.none,
                                        alignment: Alignment.center,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ));
                            },
                          ),
                        ) ,
                        (controller.getCurrentPrice(data: videoData?.sizePrice)?.isEmpty ?? false)? SizedBox.shrink() :  Obx(
                          () => CustomSimpleText(
                              text:
                                  "Price: ${controller.getCurrentPrice(data: videoData?.sizePrice)}"),
                        ),
                        (controller.getCurrentQty(data: videoData?.sizeQty)?.isEmpty ?? false) ? SizedBox.shrink(): Obx(
                          () => CustomSimpleText(
                              text:
                                  "Quantity: ${controller.getCurrentQty(data: videoData?.sizeQty)}"),
                        ),
                         SizedBox(
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: videoData?.color?.length,
                              itemBuilder: (_, index) {
                                var item = videoData?.color?[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: InkWell(
                                    onTap: () {
                                      controller.selectSizeColor.value =
                                          item ?? '';
                                    },
                                    child: Center(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: controller.selectSizeColor
                                            .value.isEmpty ? SizedBox.shrink() : Obx(() => Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: HexColor(item ?? '')),
                                              child: controller.selectSizeColor
                                                          .value !=
                                                      item
                                                  ? SizedBox.shrink()
                                                  : Center(
                                                    child: Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                      size: 17,
                                                      ),
                                                  ),
                                            )),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        (controller.getCurrentPrice(data: videoData?.sizePrice)?.isEmpty ?? false)? SizedBox.shrink() :  CustomSimpleText(
                          text: "Price Details",
                          fontWeight: FontWeight.bold,
                          fontSize: AppSizes.size16,
                          color: AppColors.black,
                        ),
                        (controller.getCurrentPrice(data: videoData?.sizePrice)?.isEmpty ?? false)? SizedBox.shrink() :  Obx(
                          () => CustomRow(
                            title: "Total MRP",
                            price:
                                "৳${int.parse(controller.getCurrentPrice(data: videoData?.sizePrice) ?? '')}",
                          ),
                        ),
                        (controller.getCurrentPrice(data: videoData?.sizePrice)?.isEmpty ?? false)? SizedBox.shrink() : Divider(color: AppColors.backgroundColor),
                        (controller.getCurrentPrice(data: videoData?.sizePrice)?.isEmpty ?? false)? SizedBox.shrink() :     Obx(
                          () => CustomRow(
                            title: "Total ",
                            price:
                                "৳${int.parse(controller.getCurrentPrice(data: videoData?.sizePrice) ?? '')}",
                          ),
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
                      Obx(()=> controller.isBuyNowLoading.value ? const Center(child: CircularProgressIndicator(),) :  InkWell(
                        onTap: () {
                          if((controller.getCurrentPrice(data: videoData?.sizePrice)?.isEmpty ?? false)){
                            errorToast(context: context, msg: "Some information missing");
                          }else if((videoData?.color == null)){
                            errorToast(context: context, msg: "Some information missing");
                          }else if( (controller.getCurrentQty(data: videoData?.sizeQty)?.isEmpty ?? false)){
                            errorToast(context: context, msg: "Some information missing");
                          }else{
                            Navigator.pop(context);
                            // controller.billingDetails(context);
                            controller.buyNowFunction(videoID: videoData?.id).then((value){
                              controller.homeController.checkOutFunction(from: "singleCheckout");
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
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
                      )),
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
                      icon: const Icon(Icons.arrow_forward_ios, size: 15))
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
}
