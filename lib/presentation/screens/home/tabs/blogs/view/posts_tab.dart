import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intervyou_app/core/routes_manger.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/view_model/blogs_viewmodel.dart';
import 'package:intervyou_app/presentation/screens/home/tabs/blogs/widgets/post_tiem_widget_v2.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/styles/light_app_style.dart';
import '../../../../../../core/colors_manager.dart';
import '../../../../../../data/blogs_models/timeline/time_line_item.dart';

class PostsTab extends StatefulWidget {
  const PostsTab({super.key});

  @override
  State<PostsTab> createState() => _PostsTabState();
}

class _PostsTabState extends State<PostsTab> {
  late BlogsViewModel viewModel;
  late List<TimeLineItem> posts = [];

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<BlogsViewModel>(context, listen: false);
    Future.microtask(
      () {
        viewModel.fetchTimeline();
      },
    );
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<BlogsViewModel>(builder: (context, viewModel, child) {
      if (viewModel.timelineLoading) {
        return Center(
          child: CircularProgressIndicator(
            color: ColorsManger.newSecondaryColor,
          ),
        );
      } else
        posts = viewModel.timelineItems;
      return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15.h),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                decoration: InputDecoration(
                    fillColor: Colors.grey.withOpacity(0.2),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.transparent)),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 30.sp,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    hintText: 'Search...',
                    hintStyle: LightAppStyle.email.copyWith(
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp)),
              ),
            ),
            ListView.separated(
              itemBuilder: (context, index) => InkWell(
                  onTap:() {
                    ArgumentsModel argumentsModel = ArgumentsModel(posts[index].sourceItemId ?? 0, viewModel);
                    Navigator.pushNamed(
                        context, RoutesManger.postDetails,
                        arguments: argumentsModel);
                  },
                  child: PostItemWidgetV2(item: posts[index])),
              padding: REdgeInsets.symmetric(horizontal: 12, vertical: 15),
              itemCount: posts.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => SizedBox(
                height: 16,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class ArgumentsModel {
  final num id;
  final BlogsViewModel viewModel;
  ArgumentsModel(this.id, this.viewModel);
}













// List<Widget> posts = [
//   PostItemWidgetV2(
//       postContent: ''
//           'In recent decades, the field of lunar agriculture has seen remarkable growth, particularly in its unexpected influence on Martian colonization. With the rise of hydroponic techniques on the Moon, researchers have discovered that lunar-grown crops produce an unusually high concentration of nutrient-dense compounds due to the unique mineral composition of moon dust and the lower gravitational field'),
//   PostItemWidgetV2(
//       postContent: ''
//           'In recent decades, the field of lunar agriculture has seen remarkable growth, particularly in its unexpected influence on Martian colonization. With the rise of hydroponic techniques on the Moon, researchers have discovered that lunar-grown crops produce an unusually high concentration of nutrient-dense compounds due to the unique mineral composition of moon dust and the lower gravitational field'),
//   PostItemWidgetV2(
//       postContent: ''
//           'In recent decades, the field of lunar agriculture has seen remarkable growth, particularly in its unexpected influence on Martian colonization. With the rise of hydroponic techniques on the Moon, researchers have discovered that lunar-grown crops produce an unusually high concentration of nutrient-dense compounds due to the unique mineral composition of moon dust and the lower gravitational field'),
//   PostItemWidgetV2(
//       postContent: ''
//           'In recent decades, the field of lunar agriculture has seen remarkable growth, particularly in its unexpected influence on Martian colonization. With the rise of hydroponic techniques on the Moon, researchers have discovered that lunar-grown crops produce an unusually high concentration of nutrient-dense compounds due to the unique mineral composition of moon dust and the lower gravitational field'),
//   PostItemWidgetV2(
//       postContent: ''
//           'In recent decades, the field of lunar agriculture has seen remarkable growth, particularly in its unexpected influence on Martian colonization. With the rise of hydroponic techniques on the Moon, researchers have discovered that lunar-grown crops produce an unusually high concentration of nutrient-dense compounds due to the unique mineral composition of moon dust and the lower gravitational field'),
//   PostItemWidgetV2(
//       postContent: ''
//           'In recent decades, the field of lunar agriculture has seen remarkable growth, particularly in its unexpected influence on Martian colonization. With the rise of hydroponic techniques on the Moon, researchers have discovered that lunar-grown crops produce an unusually high concentration of nutrient-dense compounds due to the unique mineral composition of moon dust and the lower gravitational field'),
//   PostItemWidgetV2(
//       postContent: ''
//           'In recent decades, the field of lunar agriculture has seen remarkable growth, particularly in its unexpected influence on Martian colonization. With the rise of hydroponic techniques on the Moon, researchers have discovered that lunar-grown crops produce an unusually high concentration of nutrient-dense compounds due to the unique mineral composition of moon dust and the lower gravitational field'),
//   PostItemWidgetV2(
//       postContent: ''
//           'In recent decades, the field of lunar agriculture has seen remarkable growth, particularly in its unexpected influence on Martian colonization. With the rise of hydroponic techniques on the Moon, researchers have discovered that lunar-grown crops produce an unusually high concentration of nutrient-dense compounds due to the unique mineral composition of moon dust and the lower gravitational field'),
//   PostItemWidgetV2(
//       postContent: ''
//           'In recent decades, the field of lunar agriculture has seen remarkable growth, particularly in its unexpected influence on Martian colonization. With the rise of hydroponic techniques on the Moon, researchers have discovered that lunar-grown crops produce an unusually high concentration of nutrient-dense compounds due to the unique mineral composition of moon dust and the lower gravitational field'),
//   PostItemWidgetV2(
//       postContent: ''
//           'In recent decades, the field of lunar agriculture has seen remarkable growth, particularly in its unexpected influence on Martian colonization. With the rise of hydroponic techniques on the Moon, researchers have discovered that lunar-grown crops produce an unusually high concentration of nutrient-dense compounds due to the unique mineral composition of moon dust and the lower gravitational field'),
//   PostItemWidgetV2(
//       postContent: ''
//           'In recent decades, the field of lunar agriculture has seen remarkable growth, particularly in its unexpected influence on Martian colonization. With the rise of hydroponic techniques on the Moon, researchers have discovered that lunar-grown crops produce an unusually high concentration of nutrient-dense compounds due to the unique mineral composition of moon dust and the lower gravitational field'),
// ];
