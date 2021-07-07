import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;
  UserImagePicker(this.imagePickFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final _picker = ImagePicker();
    final _pickedImage = await _picker.getImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );

    if (_pickedImage == null) {
      return;
    }

    setState(() {
      _storedImage = File(_pickedImage.path);
    });

    widget.imagePickFn(_storedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 60,
          backgroundImage:
              _storedImage != null ? FileImage(_storedImage!) : null,
        ),
        TextButton.icon(
          onPressed: _takePicture,
          icon: Icon(Icons.camera),
          label: Text('Add image'),
        ),
      ],
    );
  }
}
