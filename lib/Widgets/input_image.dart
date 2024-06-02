import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InputImage extends StatefulWidget {
  const InputImage({super.key, required this.onPickImage});
  final void Function(File image) onPickImage;

  @override
  _InputImageState createState() => _InputImageState();
}

class _InputImageState extends State<InputImage> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    {
      final imagePicker = ImagePicker();
      final pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
      );
      if (pickedImage == null) {
        return;
      }
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
      widget.onPickImage(_selectedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _pickImage,
      icon: const Icon(Icons.camera),
      label: const Text('Add Image'),
    );
    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _pickImage,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return Container(
      height: 250,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
