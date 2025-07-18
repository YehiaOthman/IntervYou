import 'package:flutter/material.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view_model/blogs_viewmodel.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/view_model/learn_provider.dart';
import 'package:provider/provider.dart';
import 'my_app/my_app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LearnViewModel()),
        ChangeNotifierProvider(create: (_) => BlogsViewModel()),
      ],
      child: MyApp(),
    ),
  );
}