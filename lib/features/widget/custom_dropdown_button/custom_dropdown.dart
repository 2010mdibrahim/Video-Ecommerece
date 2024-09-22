import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../core/model/dropdown_model.dart';
import '../custom_elevatedButton/custom_text.dart';

class CustomDropDown extends StatelessWidget {
  final String? fieldTitle, hint;
  final DropdownModel? selectedItem;
  final List<DropdownModel> spinnerItemList;
  final Color? dropdownColor;
  final Color? titleColor, valueTextColor;
  final bool? isEnable;
  final double? manuMaxHeight, titleFontSize;
  final void Function(DropdownModel) onChanged;

  const CustomDropDown({
    super.key,
    this.fieldTitle,
    required this.spinnerItemList,
    required this.onChanged,
    this.selectedItem,
    this.dropdownColor,
    this.hint,
    this.titleColor,
    this.manuMaxHeight,
    this.isEnable,
    this.titleFontSize,
    this.valueTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        fieldTitle != null
            ? FieldTitleText(
                text: fieldTitle!,
                color: titleColor,
                fontSize: titleFontSize,
              )
            : const SizedBox(),
        fieldTitle != null
            ? const SizedBox(
                height: 3,
              )
            : const SizedBox(),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: 50,
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(5),
                  // color: Colors.grey.withOpacity(0.1),
                  border: Border.all(
                    width: 0.6,
                    color: Colors.grey.withOpacity(0.4),
                  ),
                ),
                child: DropdownButton<DropdownModel>(
                  dropdownColor: dropdownColor ?? AppColors.white,
                  hint: Text(
                    "$hint",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  value: selectedItem,

                  icon: const Icon(Icons.arrow_drop_down),
                  underline: const SizedBox(),
                  isExpanded: true,
                  elevation: 16,
                  menuMaxHeight: manuMaxHeight,
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                  onChanged: isEnable == false
                      ? null
                      : (newValue) {
                          onChanged(newValue!);
                        },
                  items: spinnerItemList.map<DropdownMenuItem<DropdownModel>>(
                      (DropdownModel value) {
                    return DropdownMenuItem<DropdownModel>(
                      key: UniqueKey(), // Set a unique key here
                      value: value,
                      child: CustomSimpleText(
                        text: value.name,
                        color: valueTextColor ?? Colors.black,
                        alignment: TextAlign.start,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomDropDownForThreeData extends StatelessWidget {
  final String? fieldTitle, hint;
  final DropdownModelForThreeValue? selectedItem;
  final List<DropdownModelForThreeValue> spinnerItemList;
  final Color? dropdownColor;
  final Color? titleColor, valueTextColor;
  final bool? isEnable;
  final double? manuMaxHeight, titleFontSize;
  final void Function(DropdownModelForThreeValue) onChanged;

  const CustomDropDownForThreeData(
      {Key? key,
      this.fieldTitle,
      required this.spinnerItemList,
      required this.onChanged,
      this.selectedItem,
      this.dropdownColor,
      this.hint,
      this.titleColor,
      this.manuMaxHeight,
      this.isEnable,
      this.titleFontSize,
      this.valueTextColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        fieldTitle != null
            ? FieldTitleText(
                text: fieldTitle!,
                color: titleColor,
                fontSize: titleFontSize,
              )
            : const SizedBox(),
        fieldTitle != null
            ? const SizedBox(
                height: 3,
              )
            : const SizedBox(),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: 50,
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(5),
                  // color: Colors.grey.withOpacity(0.1),
                  border: Border.all(
                    width: 0.6,
                    color: Colors.grey.withOpacity(0.4),
                  ),
                ),
                child: DropdownButton<DropdownModelForThreeValue>(
                  dropdownColor: dropdownColor ?? AppColors.white,
                  hint: Text(
                    "$hint",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  value: selectedItem,

                  icon: const Icon(Icons.arrow_drop_down),
                  underline: const SizedBox(),
                  isExpanded: true,
                  // Hide default dropdown icon
                  elevation: 16,
                  menuMaxHeight: manuMaxHeight,
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                  onChanged: isEnable == false
                      ? null
                      : (newValue) {
                          onChanged(newValue!);
                        },
                  items: spinnerItemList
                      .map<DropdownMenuItem<DropdownModelForThreeValue>>(
                          (DropdownModelForThreeValue value) {
                    return DropdownMenuItem<DropdownModelForThreeValue>(
                      key: UniqueKey(), // Set a unique key here
                      value: value,
                      child: CustomSimpleText(
                        text: value.name,
                        color: valueTextColor ?? Colors.black,
                        alignment: TextAlign.start,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
