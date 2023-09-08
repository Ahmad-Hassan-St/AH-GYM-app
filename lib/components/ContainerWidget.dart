import 'package:flutter/material.dart';

import '../utils/colors.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({
    super.key,
    required String image_path,
    required String productname,
    required Icon iconDelete,
    required Icon iconEdit,
    required VoidCallback onpressed,
    required VoidCallback onPressEdit,
    required VoidCallback onPressDelete,
  })  : _image_path = image_path,
        _onpressed = onpressed,
        _iconEdit = iconEdit,
        _iconDelete = iconDelete,
        _productname = productname,
        _onPressDelete = onPressDelete,
        _onPressEdit = onPressEdit;

  final String _image_path;
  final String _productname;
  final Icon _iconDelete;
  final Icon _iconEdit;
  final VoidCallback _onpressed;
  final VoidCallback _onPressEdit;
  final VoidCallback _onPressDelete;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        onTap: _onpressed,
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          decoration: BoxDecoration(
            color: kThirdColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                spreadRadius: 1,
                offset: const Offset(0.2, 0.2),
                color: Colors.grey.withOpacity(0.5),
              ),
            ],
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  ImageWidget(
                      screenHeight: screenHeight,
                      image_path: NetworkImage(_image_path)),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(
                _productname,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: _onPressEdit,
                      icon: _iconEdit,
                    ),
                    IconButton(
                      onPressed: _onPressDelete,
                      icon: _iconDelete,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.screenHeight,
    required ImageProvider image_path,
  }) : _image_path = image_path;

  final double screenHeight;
  final ImageProvider _image_path;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: kGradient,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image(
          fit: BoxFit.cover,
          height: screenHeight * 0.17,
          width: double.infinity,
          image: _image_path,
        ),
      ),
    );
  }
}
