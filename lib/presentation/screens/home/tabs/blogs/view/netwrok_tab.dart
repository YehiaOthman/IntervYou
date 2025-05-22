import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NetwrokTab extends StatefulWidget {
  const NetwrokTab({super.key});

  @override
  State<NetwrokTab> createState() => _NetwrokTabState();
}

class _NetwrokTabState extends State<NetwrokTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('NetwrokTab',style: TextStyle(color: Colors.white),),
    );
  }
}
