import 'package:flutter/material.dart';
import 'package:intervyou_app/core/colors_manager.dart';




class Blogs extends StatefulWidget {
  const Blogs({super.key});

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.newWhite,
    );
  }
}
