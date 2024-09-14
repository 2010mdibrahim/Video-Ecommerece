import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../core/utils/appStyle.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_sizes.dart';
import '../../../../widget/cached_image_network/custom_cached_image_network.dart';

class TransferMoneyHistoryWidget extends StatelessWidget {
  const TransferMoneyHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              color: HexColor("F4F7FE"),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 12),
                child: SizedBox(
                  width:
                  MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius:
                        BorderRadius.circular(100),
                        child:
                        const CustomCachedImageNetwork(
                          imageUrl:
                          "https://static.vecteezy.com/system/resources/thumbnails/041/714/266/small_2x/ai-generated-professional-man-in-suit-with-arms-crossed-on-transparent-background-stock-png.png",
                          height: 40,
                          weight: 40,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context)
                            .size
                            .width *
                            0.76,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .center,
                                children: [
                                  CustomSimpleText(
                                    text:
                                    "Md. Mehedi Hasan",
                                    fontSize:
                                    AppSizes.size14,
                                    color:
                                    AppColors.black,
                                    fontWeight:
                                    FontWeight.w500,
                                  ),
                                  CustomSimpleText(
                                    text: "\$ 1,000",
                                    fontSize:
                                    AppSizes.size14,
                                    color:
                                    AppColors.black,
                                    fontWeight:
                                    FontWeight.normal,
                                  ),
                                ],
                              ),
                              CustomSimpleText(
                                text: "16, Dec 2024",
                                fontSize: AppSizes.size10,
                                fontWeight:
                                FontWeight.normal,
                                color: AppColors.black,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
