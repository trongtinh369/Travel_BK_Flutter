import 'dart:io';

import 'package:booking_tour_flutter/presentation/widgets_v/delete_button_widget.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/pick_image_button/pick_image_button.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/search_bar_widget.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  XFile? selectedImage;
  List<String> selectedProvinces = [];
  final TextEditingController _controller = TextEditingController();

  XFile? singleImage;
  List<XFile> selectedImages = [];

  String? selectedProvince;
  List<String> selectedMultipleProvinces = [];

  final List<String> provinces = [
    'Hà Nội',
    'TP. Hồ Chí Minh',
    'Đà Nẵng',
    'Hải Phòng',
    'Cần Thơ',
    'An Giang',
    'Bà Rịa - Vũng Tàu',
    'Bắc Giang',
    'Bắc Kạn',
    'Bạc Liêu',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PickImageButton(
              text: 'Chọn ảnh đại diện',
              allowMultiple: false,
              onImagesPicked: (images) {
                setState(() {
                  // singleImage = images.isNotEmpty ? images.first : null;
                });
              },
            ),

            PickImageButton(
              text: 'Chọn nhiều ảnh',
              allowMultiple: true,
              onImagesPicked: (images) {
                setState(() {
                  // selectedImages = images;
                });
              },
            ),

            if (singleImage != null) ...[
              const SizedBox(height: 20),
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(File(singleImage!.path), fit: BoxFit.cover),
                ),
              ),
            ],

            if (selectedImages.isNotEmpty) ...[
              const SizedBox(height: 20),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: selectedImages.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(selectedImages[index].path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],

            const SizedBox(height: 20),
            DropDownWidget<String>(
              title: 'Tỉnh/Thành phố',
              options: provinces,
              itemToString: (province) => province,
              value: selectedProvince,
              onChanged: (province) {
                setState(() {
                  selectedProvince = province;
                });
              },
            ),
            const SizedBox(height: 20),
            DeleteButtonWidget(
              onDelete: () {
                setState(() {
                  singleImage = null;
                  selectedImages.clear();
                  selectedProvince = null;
                  selectedMultipleProvinces.clear();
                });
              },
            ),

            SearchBarWidget(
              controller: _controller,
              onChanged: (value) {
                // TODO: Xử lý khi giá trị trong ô tìm kiếm thay đổi
              },
              onClear: () {
                _controller.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
