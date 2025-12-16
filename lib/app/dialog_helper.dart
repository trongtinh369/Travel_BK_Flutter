import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/presentation/widgets/bk_button.dart';
import 'package:booking_tour_flutter/presentation/widgets_dialog/general_dialog.dart';
import 'package:booking_tour_flutter/presentation/widgets_dialog/loading_dialog.dart';
import 'package:flutter/material.dart';
import '../presentation/widgets_dialog/generic_selected_dialog.dart';

class DialogHelper {
  static bool _isShowedDialog = false;
  static BuildContext? _dialogContext;

  static Future<void> showLoadingDialog() {
    showDialog(
      barrierDismissible: false,
      context: AppNavigator.currentContext,
      builder: (context) {
        _dialogContext = context;
        return PopScope(canPop: false, child: LoadingDialog());
      },
    );

    return Future.delayed(Duration(milliseconds: 200));
  }

  static void dismissDialog() {
    if (_dialogContext != null && _dialogContext!.mounted) {
      Navigator.pop(_dialogContext!);
    }
  }

  /// Single select: returns T?
  static Future<T?> selectOne<T>({
    required BuildContext context,
    required String title,
    required List<T> items,
    required String Function(T item) display,
    String searchHint = 'Tìm địa điểm',
    String confirmText = 'Xác nhận',
    String cancelText = 'Hủy',
    T? initial,
  }) async {
    if (_isShowedDialog) {
      return null;
    }
    _isShowedDialog = true;
    FocusManager.instance.primaryFocus?.unfocus();

    await Future.delayed(const Duration(milliseconds: 50));

    var result = await showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => SelectionDialog<T>(
            title: title,
            items: items,
            display: display,
            searchHint: searchHint,
            confirmText: confirmText,
            cancelText: cancelText,
            isMultiSelect: false,
            preSelectedItems: initial == null ? const [] : [initial],
          ),
    );

    FocusManager.instance.primaryFocus?.unfocus();

    _isShowedDialog = false;
    return result;
  }

  static Future<List<T>?> selectMany<T>({
    required BuildContext context,
    required String title,
    required List<T> items,
    required String Function(T item) display,
    String searchHint = 'Tìm địa điểm',
    String confirmText = 'Xác nhận',
    String cancelText = 'Hủy',
    List<T> initial = const [],
  }) async {
    if (_isShowedDialog) {
      return null;
    }
    _isShowedDialog = true;
    FocusManager.instance.primaryFocus?.unfocus();

    await Future.delayed(const Duration(milliseconds: 50));

    if (!context.mounted) {
      return null;
    }

    final result = await showDialog<List<T>>(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => SelectionDialog<T>(
            title: title,
            items: items,
            display: display,
            searchHint: searchHint,
            confirmText: confirmText,
            cancelText: cancelText,
            isMultiSelect: true,
            preSelectedItems: initial,
          ),
    );

    FocusManager.instance.primaryFocus?.unfocus();

    _isShowedDialog = false;
    return result;
  }

  static Future<void> showInformDialog(Widget body) {
    return showDialog(
      barrierDismissible: true,
      context: AppNavigator.currentContext,
      builder: (context) {
        return GeneralDialog(
          title: "Thông báo",
          body: body,
          footer: Center(
            child: BkButton(
              onPressed: () {
                Navigator.pop(context);
              },
              title: "Xác nhận",
            ),
          ),
        );
      },
    );
  }

  static Future<bool> showConfirmDialog({
    required Widget body,
  }) async {
    var result = await showDialog<bool?>(
      barrierDismissible: true,
      context: AppNavigator.currentContext,
      builder: (context) {
        return GeneralDialog(
          title: "Thông báo",
          body: body,
          footer: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BkButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                backgroundColor: AppColors.delete,
                title: "Hủy",
              ),
              SizedBox(width: 10),
              BkButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                title: "Xác nhận",
              ),
            ],
          ),
        );
      },
    );

    return result ?? false;
  }
}
