// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/app/formatter_helper.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeWidget extends StatefulWidget {
  final String qr;
  final DateTime expiredAt;

  QrCodeWidget({super.key, required this.qr, required this.expiredAt});

  @override
  State<QrCodeWidget> createState() => _QrCodeWidgetState();
}

class _QrCodeWidgetState extends State<QrCodeWidget> {
  late bool _isShowQr;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    if (DateTime.now().isAfter(widget.expiredAt)) {
      _isShowQr = false;
    } else {
      _isShowQr = true;
      int timeLeft = widget.expiredAt.difference(DateTime.now()).inSeconds;
      _timer = Timer.periodic(Duration(seconds: timeLeft), (timer) {
        timer.cancel();
        setState(() {
          _isShowQr = false;
        });
      });
    }
  }
  
  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    int timeLeft = widget.expiredAt.difference(DateTime.now()).inSeconds;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [_CountDownWidget(secondLeft: timeLeft), _buildQr(context)],
    );
  }

  Widget _buildQr(BuildContext context) {
    if (_isShowQr) {
      return SizedBox(
        width: 300,
        height: 300,
        child: QrImageView(data: widget.qr),
      );
    } else {
      return Container(
        width: 300,
        height: 300,
        color: AppColors.gray,
        child: Center(
          child: Text(
            "Mã Qr đã hết hạn",
            style: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(color: AppColors.white),
          ),
        ),
      );
    }
  }
}

class _CountDownWidget extends StatefulWidget {
  final int secondLeft;

  const _CountDownWidget({Key? key, required this.secondLeft})
    : super(key: key);

  @override
  State<_CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<_CountDownWidget> {
  late int secondsLeft;
  late Timer? _timer;

  @override
  void initState() {
    super.initState();

    secondsLeft = widget.secondLeft;
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        secondsLeft = secondsLeft - 1;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (secondsLeft < 1) {
      return Text("");
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        "Nếu sau ${FormatterHelper.formatDuration(Duration(seconds: secondsLeft))} bạn chưa thanh toán thì chuyến đi của bạn sẽ bị hủy",
        style: AppFonts.text18,
      ),
    );
  }
}
