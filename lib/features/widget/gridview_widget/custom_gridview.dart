import 'package:e_commerce/core/utils/appStyle.dart';
import 'package:e_commerce/core/utils/app_assets.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/utils/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        itemCount: 10,
        crossAxisSpacing: 8,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Tile(
                index: index,
                extent: 190,
              ),
              Positioned(
                  right: 15,
                  top: 0,
                  child: Padding(
                    padding: EdgeInsets.only(top: (index) % 2 == 0 ? 0 : 20),
                    child: Image.asset(
                      AppAssets.shoe,
                      height: AppSizes.size41,
                      width: AppSizes.size41,
                    ),
                  ))
            ],
          );
        },
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final int index;
  final double extent;

  Tile({required this.index, required this.extent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: (index + 1) % 2 == 0 ? 60 : 40),
      child: Padding(
        padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 143,
            decoration: BoxDecoration(
              color: AppColors.allProductCardColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26.withOpacity(0.16),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: CustomSimpleText(
                text: "Shoes",
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
