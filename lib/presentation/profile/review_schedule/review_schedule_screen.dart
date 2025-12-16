import 'package:booking_tour_flutter/app/dependency_injection/format_date_number.dart'
    as FormatterHelper;
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dialog_helper.dart';
import 'package:booking_tour_flutter/presentation/profile/review_schedule/cubit/review_schedule_cubit.dart';
import 'package:booking_tour_flutter/presentation/profile/review_schedule/cubit/review_schedule_state.dart';
import 'package:booking_tour_flutter/presentation/profile/review_schedule/widgets/stars_widget.dart';
import 'package:booking_tour_flutter/presentation/widgets/bk_button.dart';
import 'package:booking_tour_flutter/presentation/widgets/bk_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class ReviewScheduleScreen extends StatelessWidget {
  final TextEditingController _commentController = TextEditingController();

  ReviewScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ReviewScheduleCubit>();
    cubit.getData();

    return BlocConsumer<ReviewScheduleCubit, ReviewScheduleState>(
      bloc: cubit,
      listener: (context, state) async {
        if (state.errorMessage != null) {
          await DialogHelper.showInformDialog(Text(state.errorMessage!));
        }
        if (state.isBack) {
          await DialogHelper.showInformDialog(Text("Gửi đánh giá thành công"));
          if (context.mounted) {
            Navigator.pop(context);
          }
        }
      },
      builder: (context, state) {
        _commentController.setText(state.review);
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(title: Text("Đánh giá chuyến đi")),
          body: _build(context, state),
        );
      },
    );
  }

  Widget _build(BuildContext context, ReviewScheduleState state) {
    if (state.isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return _buildWhenLoaded(context, state);
    }
  }

  Widget _buildWhenLoaded(BuildContext context, ReviewScheduleState state) {
    var cubit = context.read<ReviewScheduleCubit>();
    return CustomScrollView(
      slivers: [
        //tour
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.backgroundAppBarTheme,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Image.asset(
                    'assets/images/destination_place.png',
                    width: 32,
                    height: 32,
                  ),
                  title: Text(
                    "Chuyến đi ${cubit.state.schedule!.tour.title}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/images/code.png',
                    width: 32,
                    height: 32,
                  ),
                  title: Text(
                    "Mã chuyến đi: ${cubit.state.schedule!.code}",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: AppColors.white),
                  ),
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/images/calender.png',
                    width: 32,
                    height: 32,
                  ),
                  title: Text(
                    "${FormatterHelper.formatDate(cubit.state.schedule!.startDate)} - ${FormatterHelper.formatDate(cubit.state.schedule!.endDate)}",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: AppColors.white),
                  ),
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/images/start_place.png',
                    width: 32,
                    height: 32,
                  ),
                  title: Text(
                    "Khởi hành từ Tp. Hồ Chí Minh",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: AppColors.white),
                  ),
                ),
              ],
            ),
          ),
        ),

        //comment
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //stars
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Chất lượng chuyến đi",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      StarRating(
                        rating: state.stars,
                        onRatingChanged: (stars) {
                          cubit.setStars(stars);
                        },
                        isEnable: !state.isSentReview,
                      ),
                    ],
                  ),

                  //comment
                  BkTextfield(
                    controller: _commentController,
                    hint: "Viết đánh giá của bạn tại đây",
                    minLines: 12,
                    maxLines: 20,
                    isEnable: !state.isSentReview,
                    onChange: (comment) => cubit.setComment(comment),
                    isTrimOnChange: false,
                  ),
                ],
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 50)),
        SliverToBoxAdapter(
          child: Visibility(
            visible: !state.isSentReview,
            child: Center(
              child: BkButton(
                onPressed: () {
                  cubit.sendReview();
                },
                title: "Gửi",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
