import 'package:flutter/material.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view_model/blogs_viewmodel.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/learn/view_model/learn_provider.dart';
import 'package:provider/provider.dart';
import 'my_app/my_app.dart';

void main() {
  runApp(
    // THE FIX: Wrap your entire application with MultiProvider.
    // This creates your ViewModels once and makes them available
    // to every single screen in your app.
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LearnViewModel()),
        ChangeNotifierProvider(create: (_) => BlogsViewModel()),
        // If you have more app-wide ViewModels, add them here.
      ],
      child: MyApp(),
    ),
  );
}