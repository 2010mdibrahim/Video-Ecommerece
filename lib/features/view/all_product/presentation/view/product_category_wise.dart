import 'package:e_commerce/features/view/all_product/presentation/widget/all_products_widget.dart';
import 'package:e_commerce/features/widget/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slightWhite,
      appBar: CustomAppBar(
        title: "Products",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: AllProductsWidget(),
    );
  }
}
