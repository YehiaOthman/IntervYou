import 'package:flutter/cupertino.dart';
import 'package:flutter_pw_validator/Resource/MyColors.dart';

class Preferences extends StatefulWidget {
  const Preferences({super.key});

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      color: MyColors.red,
    );
  }
}
