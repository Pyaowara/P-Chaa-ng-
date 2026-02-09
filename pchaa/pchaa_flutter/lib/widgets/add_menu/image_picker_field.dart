import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Widget for picking and displaying menu item image
class ImagePickerField extends StatefulWidget {
  final XFile? initialImage;
  final String? initialImageUrl;
  final Function(XFile?) onImageSelected;

  const ImagePickerField({
    super.key,
    this.initialImage,
    this.initialImageUrl,
    required this.onImageSelected,
  });

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  bool _removeImage = false;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.initialImage;
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() {
          _selectedImage = image;
          _removeImage = false;
        });
        widget.onImageSelected(image);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void _removeSelectedImage() {
    setState(() {
      _selectedImage = null;
      _removeImage = true;
    });
    widget.onImageSelected(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'รูปภาพเมนู',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
            child: _buildImageContent(),
          ),
        ),
        if (_selectedImage != null ||
            (widget.initialImageUrl != null && !_removeImage))
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: TextButton.icon(
              onPressed: _removeSelectedImage,
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              label: const Text(
                'ลบรูปภาพ',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildImageContent() {
    if (_selectedImage != null) {
      // Show selected image
      if (kIsWeb) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            _selectedImage!.path,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
        );
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            File(_selectedImage!.path),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
        );
      }
    } else if (widget.initialImageUrl != null && !_removeImage) {
      // Show existing image from URL
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          widget.initialImageUrl!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 200,
          errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
        ),
      );
    } else {
      return _buildPlaceholder();
    }
  }

  Widget _buildPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_photo_alternate_outlined,
          size: 48,
          color: Colors.grey.shade400,
        ),
        const SizedBox(height: 8),
        Text(
          'แตะเพื่อเลือกรูปภาพ',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
