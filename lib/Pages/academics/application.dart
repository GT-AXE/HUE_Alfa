// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نموذج الطلب',
      debugShowCheckedModeBanner: false,
      theme: _buildAppTheme(),
      home: const ApplicationFormPage(),
    );
  }

  ThemeData _buildAppTheme() {
    return ThemeData(
      primarySwatch: Colors.yellow,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.deepPurple[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class ApplicationFormPage extends StatefulWidget {
  const ApplicationFormPage({super.key});

  @override
  State<ApplicationFormPage> createState() => _ApplicationFormPageState();
}

class _ApplicationFormPageState extends State<ApplicationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  File? _studentPhoto;
  File? _guardianPhoto;
  String? _selectedCollege;

  final Map<String, TextEditingController> _controllers = {
    'studentName': TextEditingController(),
    'studentPhone': TextEditingController(),
    'guardianName': TextEditingController(),
    'guardianPhone': TextEditingController(),
    'residence': TextEditingController(),
    'guardianResidence': TextEditingController(),
    'studentId': TextEditingController(),
    'guardianId': TextEditingController(),
    'percentage': TextEditingController(),
    'totalScore': TextEditingController(),
    'seatNumber': TextEditingController(),
  };

  final List<String> _colleges = [
    'هندسة الذكاء الاصطناعي',
    'الفنون الجميلة',
    'العلاج الطبيعي',
    'الطب البشري',
    'تكنولوجيا العلوم الصحية التطبيقية',
    'اللغات والترجمة',
    'إدارة الأعمال',
    'الصيدلة',
    'طب الأسنان',
    'الهندسة',
  ];

  final Map<String, double> _collegeWeights = {
    'هندسة الذكاء الاصطناعي': 1.0,
    'الفنون الجميلة': 0.9,
    'العلاج الطبيعي': 0.85,
    'الطب البشري': 0.95,
    'تكنولوجيا العلوم الصحية التطبيقية': 0.8,
    'اللغات والترجمة': 0.75,
    'إدارة الأعمال': 0.9,
    'الصيدلة': 0.92,
    'طب الأسنان': 0.93,
    'الهندسة': 0.97,
  };

  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نموذج طلب الالتحاق بالكلية'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildPersonalInfoSection(),
                  _buildGuardianInfoSection(),
                  _buildAcademicInfoSection(),
                  _buildDocumentsSection(),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return _buildSection(
      title: 'المعلومات الشخصية',
      icon: Icons.person,
      children: [
        _buildTextField('اسم الطالب', 'studentName'),
        _buildTextField('رقم الهاتف', 'studentPhone', TextInputType.phone),
        _buildTextField('عنوان السكن', 'residence'),
        _buildTextField('رقم الهوية', 'studentId'),
      ],
    );
  }

  Widget _buildGuardianInfoSection() {
    return _buildSection(
      title: 'معلومات ولي الأمر',
      icon: Icons.supervisor_account,
      children: [
        _buildTextField('اسم ولي الأمر', 'guardianName'),
        _buildTextField('هاتف ولي الأمر', 'guardianPhone', TextInputType.phone),
        _buildTextField('عنوان ولي الأمر', 'guardianResidence'),
        _buildTextField('رقم هوية ولي الأمر', 'guardianId'),
      ],
    );
  }

  Widget _buildAcademicInfoSection() {
    return _buildSection(
      title: 'المعلومات الأكاديمية',
      icon: Icons.school,
      children: [
        _buildCollegeDropdown(),
        _buildTextField('النسبة المئوية', 'percentage', TextInputType.number),
        _buildTextField('المجموع الكلي', 'totalScore', TextInputType.number),
        _buildTextField('رقم الجلوس', 'seatNumber', TextInputType.number),
      ],
    );
  }

  Widget _buildDocumentsSection() {
    return _buildSection(
      title: 'المستندات المطلوبة',
      icon: Icons.attach_file,
      children: [
        _buildImagePicker('صورة شخصية للطالب', true),
        _buildImagePicker('صورة الهوية الوطنية للطالب', true),
        _buildImagePicker('صورة شهادة الميلاد', true),
        _buildImagePicker('صورة الهوية الوطنية لولي الأمر', false),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color:  Colors.blue,
                ),
              ),
            ],
          ),
        ),
        ...children,
        const Divider(height: 40, color: Colors.grey),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    String controllerKey, [
    TextInputType? keyboardType,
  ]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: _controllers[controllerKey],
        textDirection: TextDirection.rtl,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: const Icon(Icons.edit, size: 20, color: Colors.red),
        ),
        validator: (value) => value!.isEmpty ? 'هذا الحقل مطلوب' : null,
      ),
    );
  }

  Widget _buildCollegeDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: _selectedCollege,
        items: _colleges
            .map((college) => DropdownMenuItem(
                  value: college,
                  child: Text(college, textDirection: TextDirection.rtl),
                ))
            .toList(),
        onChanged: (value) => setState(() => _selectedCollege = value),
        decoration: const InputDecoration(labelText: 'اختر الكلية'),
        validator: (value) => value == null ? 'الرجاء اختيار الكلية' : null,
      ),
    );
  }

  Widget _buildImagePicker(String label, bool isStudent) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => _pickImage(isStudent),
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color:  Colors.blue),
              ),
              child: _buildImagePreview(isStudent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePreview(bool isStudent) {
    final File? file = isStudent ? _studentPhoto : _guardianPhoto;
    
    if (file != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(file, fit: BoxFit.cover),
      );
    }
    
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.camera_alt, size: 40, color: Colors.grey),
          SizedBox(height: 8),
          Text('اضغط للرفع', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Future<void> _pickImage(bool isStudent) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.blue),
              title: const Text('الكاميرا'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.yellow),
              title: const Text('معرض الصور'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source != null) {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          if (isStudent) {
            _studentPhoto = File(pickedFile.path);
          } else {
            _guardianPhoto = File(pickedFile.path);
          }
        });
      }
    }
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text(
          'تقديم الطلب',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final percentage = double.tryParse(_controllers['percentage']!.text);
      
      if (percentage == null || percentage < 60 || percentage > 100) {
        _showError('النسبة المئوية يجب أن تكون بين 60 و 100');
        return;
      }

      final collegeWeight = _collegeWeights[_selectedCollege] ?? 1.0;
      final calculatedPercentage = percentage * collegeWeight;
      
      _showSuccess('تم الحساب: ${calculatedPercentage.toStringAsFixed(2)}%');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}