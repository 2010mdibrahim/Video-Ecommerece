import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../widget/custom_appbar/custom_appbar.dart';
import '../widget/transfer_money_history_widget.dart';

class TransferMoneyHistory extends StatelessWidget {
  const TransferMoneyHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: "Transfer History",
        textAlign: TextAlign.start,
        isTextCenter: false,
        appBarBackgroundColor: AppColors.white,
        titleColor: AppColors.black,
        backiconColor: AppColors.black,
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: const TransferMoneyHistoryWidget(),
    );
  }
}
