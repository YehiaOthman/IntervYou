import 'package:flutter/material.dart';
import 'package:intervyou_app/core/colors_manager.dart';

class RoadMap extends StatefulWidget {
  RoadMap({super.key});

  @override
  State<RoadMap> createState() => _RoadMapState();
}

class _RoadMapState extends State<RoadMap> {
  final List<Map<String, String>> phases = [
    {
      'title': 'Stateless Widgets',
      'description':
          "Stateless widgets in Flutter are widgets that don't maintain any mutable state."
    },
    {
      'title': 'Stateful Widgets',
      'description':
          "A stateful widgets is dynamic, for example, it can change its appearance in response."
    },
    {
      'title': 'Stateless Widgets',
      'description':
          "Stateless widgets in Flutter are widgets that don't maintain any mutable state."
    },
    {
      'title': 'Stateful Widgets',
      'description':
          "A stateful widgets is dynamic, for example, it can change its appearance in response."
    },
    {
      'title': 'Stateless Widgets',
      'description':
          "Stateless widgets in Flutter are widgets that don't maintain any mutable state."
    },
    {
      'title': 'Stateful Widgets',
      'description':
          "A stateful widgets is dynamic, for example, it can change its appearance in response."
    },
    {
      'title': 'Stateful Widgets',
      'description':
          "A stateful widgets is dynamic, for example, it can change its appearance in response."
    },
    {
      'title': 'Stateful Widgets',
      'description':
          "A stateful widgets is dynamic, for example, it can change its appearance in response."
    },
    {
      'title': 'Stateful Widgets',
      'description':
          "A stateful widgets is dynamic, for example, it can change its appearance in response."
    },
    {
      'title': 'Stateful Widgets',
      'description':
          "A stateful widgets is dynamic, for example, it can change its appearance in response."
    },
  ];

  int currentPhaseIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.semiBlack,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: phases.length,
                itemBuilder: (context, index) {
                  bool isCurrent = index == currentPhaseIndex;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(
                                color: ColorsManger.secondaryColor,

                              ),
                              shape: BoxShape.circle,
                            ),
                            child: isCurrent
                                ? Center(
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: ColorsManger.secondaryColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ) : null,
                          ),
                          if (index != phases.length - 1)
                            Container(
                              width: 2,
                              height: 115,
                              color: ColorsManger.secondaryColor,
                            ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              currentPhaseIndex = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isCurrent
                                  ? ColorsManger.secondaryColor
                                  : Colors.black,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: ColorsManger.secondaryColor,
                                  width: isCurrent ? 2 : 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    phases[index]['title']!,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: isCurrent ? Colors.black : Colors.white,
                                    ),
                                  ),
                                  Text(
                                    phases[index]['description']!,
                                    style: TextStyle(color: isCurrent ? Colors.black.withOpacity(0.9) : Colors.white70,fontSize: 12,
                                      fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
