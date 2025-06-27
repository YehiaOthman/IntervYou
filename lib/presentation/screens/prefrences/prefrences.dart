import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/config/handler_functions.dart';
import 'package:intervyou_app/config/styles/light_app_style.dart';
import 'package:intervyou_app/core/colors_manager.dart';

import 'choice_chip_widget.dart';

class Preferences extends StatefulWidget {
  const Preferences({super.key});

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  String? _selectedTrack;
  String? _selectedExperience;
  String? _selectedHours;

  bool _isLoading = false;

  final List<String> _tracks = ['Mobile', 'BackEnd', 'FrontEnd', 'AI'];
  final List<String> _experiences = ['Junior', 'MidLevel', 'Senior'];
  final List<String> _studyHours = ['1-2 hours', '3-4 hours', '5-8 hours'];

  void _onSavePressed() {
    if (_selectedTrack == null ||
        _selectedExperience == null ||
        _selectedHours == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an option from each category.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    HandlerFunctions.handleUpdatePreferences(
      context,
      _selectedTrack!,
      _selectedExperience!,
      _selectedHours!,
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorsManger.newSecondaryColor,
        title: Text('Preferences',
            style: LightAppStyle.email.copyWith(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600)),
        iconTheme: const IconThemeData(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.r),
            bottomRight: Radius.circular(30.r),
          ),
        ),
        toolbarHeight: 75.h,
      ),
      backgroundColor: ColorsManger.newWhite,
      body: SingleChildScrollView(
        padding: REdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Choose your track'),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: _tracks.map((track) {
                return ChoiceChipWidget(
                  text: track,
                  isSelected: _selectedTrack == track,
                  onSelected: (_) {
                    setState(() {
                      _selectedTrack = track;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 30.h),
            _buildSectionHeader('Experience Level'),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: _experiences.map((level) {
                return ChoiceChipWidget(
                  text: level,
                  isSelected: _selectedExperience == level,
                  onSelected: (_) {
                    setState(() {
                      _selectedExperience = level;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 30.h),
            _buildSectionHeader('Daily Study Hours'),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: _studyHours.map((hours) {
                return ChoiceChipWidget(
                  text: hours,
                  isSelected: _selectedHours == hours,
                  onSelected: (_) {
                    setState(() {
                      _selectedHours = hours;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 50.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _onSavePressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManger.newSecondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                  'Save',
                  style: LightAppStyle.email.copyWith(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: LightAppStyle.email.copyWith(
        color: Colors.black,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

