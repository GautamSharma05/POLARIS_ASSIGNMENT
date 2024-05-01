import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class CaptureImagesFormField extends StatefulWidget {
  final String label;
  final int noImagesToCapture;
  final String savingFolder;
  final bool mandatory;
  final Function(List<XFile>) onImagesCaptured;

  const CaptureImagesFormField({
    super.key,
    required this.label,
    required this.noImagesToCapture,
    required this.savingFolder,
    required this.mandatory,
    required this.onImagesCaptured,
  });

  @override
  State<CaptureImagesFormField> createState() => _CaptureImagesFormFieldState();
}

class _CaptureImagesFormFieldState extends State<CaptureImagesFormField> {
  final List<XFile> _capturedImages = [];

  Future<void> _captureImage() async {
    final imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _capturedImages.clear();
        _capturedImages.add(image);
      });
      widget.onImagesCaptured(_capturedImages);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (widget.mandatory)
              const Text(
                '*',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: _captureImage,
              child: const Text('Capture Image'),
            ),
          ),
        ),
        const SizedBox(height: 10),
        //Show Capture Image
        if (_capturedImages.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Captured Images:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _capturedImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(File(_capturedImages[index].path)),
                    );
                  },
                ),
              ),
            ],
          ),
      ],
    );
  }
}
