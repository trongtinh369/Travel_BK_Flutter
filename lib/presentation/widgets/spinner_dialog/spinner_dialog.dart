import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:flutter/material.dart';

class SpinnerDialog extends StatelessWidget {
  final String? content;
  final String hint;
  final VoidCallback onTap;
  final String? title;
  final double? padding;
  final bool isDisable;
  final bool isShowError;
  final String? errorMessage;

  const SpinnerDialog({
    super.key,
    this.content,
    required this.hint,
    required this.onTap,
    this.title,
    this.padding,
    this.isDisable = false,
    this.isShowError = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    var isError = errorMessage != null && isShowError;

    var primaryColor = isDisable ? AppColors.lightGrey : AppColors.black;
    Color borderColor = isError ? AppColors.error : primaryColor;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding ?? 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: title != null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title!, style: Theme.of(context).textTheme.labelLarge),
                SizedBox(height: 4),
              ],
            ),
          ),
          GestureDetector(
            onTap: isDisable ? null : onTap,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: borderColor),
              ),
              child: Row(
                children: [
                  Expanded(child: _buildTextContent(context, primaryColor)),
                  Icon(Icons.arrow_drop_down_outlined, color: primaryColor),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isError,
            child: Text(
              errorMessage ?? "",
              style: Theme.of(
                context,
              ).textTheme.labelLarge!.copyWith(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextContent(BuildContext context, Color textColor) {
    if (content != null && content!.isNotEmpty) {
      return Text(content ?? "", overflow: TextOverflow.ellipsis);
    }

    return Text(
      hint,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: textColor),
    );
  }
}
