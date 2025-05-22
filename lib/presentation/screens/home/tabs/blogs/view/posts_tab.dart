import 'package:flutter/cupertino.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/widgets/post_tiem_widget_v2.dart';

class PostsTab extends StatefulWidget {
  const PostsTab({super.key});

  @override
  State<PostsTab> createState() => _PostsTabState();
}

class _PostsTabState extends State<PostsTab> {
  List<Widget> posts = [
    PostItemWidgetV2(postContent: ''
        'In recent decades, the field of lunar agriculture has seen remarkable growth, particularly in its unexpected influence on Martian colonization. With the rise of hydroponic techniques on the Moon, researchers have discovered that lunar-grown crops produce an unusually high concentration of nutrient-dense compounds due to the unique mineral composition of moon dust and the lower gravitational field'),
    PostItemWidgetV2(postContent: ''
        'In recent decades, the field of lunar agriculture has seen remarkable growth, particularly in its unexpected influence on Martian colonization. With the rise of hydroponic techniques on the Moon, researchers have discovered that lunar-grown crops produce an unusually high concentration of nutrient-dense compounds due to the unique mineral composition of moon dust and the lower gravitational field'),
    PostItemWidgetV2(postContent: ''
        'In recent decades, the field of lunar agriculture has seen remarkable growth, particularly in its unexpected influence on Martian colonization. With the rise of hydroponic techniques on the Moon, researchers have discovered that lunar-grown crops produce an unusually high concentration of nutrient-dense compounds due to the unique mineral composition of moon dust and the lower gravitational field'),
    PostItemWidgetV2(postContent: ''
        'In recent decades, the field of lunar agriculture has seen remarkable growth, particularly in its unexpected influence on Martian colonization. With the rise of hydroponic techniques on the Moon, researchers have discovered that lunar-grown crops produce an unusually high concentration of nutrient-dense compounds due to the unique mineral composition of moon dust and the lower gravitational field'),
    PostItemWidgetV2(postContent: ''
        'In recent decades, the field of lunar agriculture has seen remarkable growth, particularly in its unexpected influence on Martian colonization. With the rise of hydroponic techniques on the Moon, researchers have discovered that lunar-grown crops produce an unusually high concentration of nutrient-dense compounds due to the unique mineral composition of moon dust and the lower gravitational field'),
    PostItemWidgetV2(postContent: ''
        'In recent decades, the field of lunar agriculture has seen remarkable growth, particularly in its unexpected influence on Martian colonization. With the rise of hydroponic techniques on the Moon, researchers have discovered that lunar-grown crops produce an unusually high concentration of nutrient-dense compounds due to the unique mineral composition of moon dust and the lower gravitational field'),
    PostItemWidgetV2(postContent: ''
        'In recent decades, the field of lunar agriculture has seen remarkable growth, particularly in its unexpected influence on Martian colonization. With the rise of hydroponic techniques on the Moon, researchers have discovered that lunar-grown crops produce an unusually high concentration of nutrient-dense compounds due to the unique mineral composition of moon dust and the lower gravitational field'),
    PostItemWidgetV2(postContent: ''
        'In recent decades, the field of lunar agriculture has seen remarkable growth, particularly in its unexpected influence on Martian colonization. With the rise of hydroponic techniques on the Moon, researchers have discovered that lunar-grown crops produce an unusually high concentration of nutrient-dense compounds due to the unique mineral composition of moon dust and the lower gravitational field'),
    PostItemWidgetV2(postContent: ''
        'In recent decades, the field of lunar agriculture has seen remarkable growth, particularly in its unexpected influence on Martian colonization. With the rise of hydroponic techniques on the Moon, researchers have discovered that lunar-grown crops produce an unusually high concentration of nutrient-dense compounds due to the unique mineral composition of moon dust and the lower gravitational field'),
    PostItemWidgetV2(postContent: ''
        'In recent decades, the field of lunar agriculture has seen remarkable growth, particularly in its unexpected influence on Martian colonization. With the rise of hydroponic techniques on the Moon, researchers have discovered that lunar-grown crops produce an unusually high concentration of nutrient-dense compounds due to the unique mineral composition of moon dust and the lower gravitational field'),
    PostItemWidgetV2(postContent: ''
        'In recent decades, the field of lunar agriculture has seen remarkable growth, particularly in its unexpected influence on Martian colonization. With the rise of hydroponic techniques on the Moon, researchers have discovered that lunar-grown crops produce an unusually high concentration of nutrient-dense compounds due to the unique mineral composition of moon dust and the lower gravitational field'),

  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: ListView.separated(itemBuilder: (context, index) => posts[index],
            itemCount: posts.length, separatorBuilder: (context, index) => SizedBox(height: 16,) ,
        ))
      ],
    );
  }
}
