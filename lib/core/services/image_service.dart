import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:hue/core/services/error_handler.dart';

class ImageService {
  static final ImageService _instance = ImageService._internal();
  factory ImageService() => _instance;
  ImageService._internal();
  
  final ImagePicker _picker = ImagePicker();
  final SupabaseClient _supabase = Supabase.instance.client;
  
  // اختيار صورة من المعرض
  Future<File?> pickImageFromGallery({
    double? maxWidth,
    double? maxHeight,
    int? quality,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: quality,
      );
      
      if (image == null) return null;
      return File(image.path);
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return null;
    }
  }
  
  // التقاط صورة من الكاميرا
  Future<File?> pickImageFromCamera({
    double? maxWidth,
    double? maxHeight,
    int? quality,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: quality,
      );
      
      if (image == null) return null;
      return File(image.path);
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return null;
    }
  }
  
  // رفع صورة إلى Supabase Storage
  Future<String?> uploadImage(File imageFile, String bucket) async {
    try {
      // إنشاء اسم فريد للملف
      final String fileExtension = path.extension(imageFile.path);
      final String fileName = '${const Uuid().v4()}$fileExtension';
      
      // رفع الملف
      await _supabase
          .storage
          .from(bucket)
          .upload(fileName, imageFile);
      
      // الحصول على رابط الصورة
      final String imageUrl = _supabase
          .storage
          .from(bucket)
          .getPublicUrl(fileName);
      
      return imageUrl;
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return null;
    }
  }
  
  // حذف صورة من Supabase Storage
  Future<bool> deleteImage(String imageUrl, String bucket) async {
    try {
      // استخراج اسم الملف من الرابط
      final Uri uri = Uri.parse(imageUrl);
      final String filePath = uri.pathSegments.last;
      
      // حذف الملف
      await _supabase
          .storage
          .from(bucket)
          .remove([filePath]);
      
      return true;
    } catch (e) {
      ErrorHandler.reportError(e, null);
      return false;
    }
  }
  
  // عرض صورة مع معالجة الأخطاء
  Widget displayImage(String? imageUrl, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return placeholder ?? const Icon(Icons.image, size: 50);
    }
    
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return placeholder ?? Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / 
                  (loadingProgress.expectedTotalBytes ?? 1)
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        ErrorHandler.reportError(error, stackTrace);
        return errorWidget ?? const Icon(Icons.broken_image, size: 50);
      },
    );
  }
}

