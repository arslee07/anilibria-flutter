import 'package:anilibria/anilibria.dart';
import 'package:anilibria_app/utils/widgets/blank_space.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:transparent_image/transparent_image.dart';

class YoutubeItem extends StatelessWidget {
  const YoutubeItem({
    required this.video,
    Key? key,
  }) : super(key: key);

  final Youtube video;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: SizedBox(
        height: ResponsiveValue(
          context,
          defaultValue: 1920 / 20,
          valueWhen: const [
            Condition.largerThan(name: MOBILE, value: 1920 / 16),
            Condition.largerThan(name: TABLET, value: 1920 / 14),
            // Condition.largerThan(name: DESKTOP, value: 550 / 2),
          ],
        ).value,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Stack(
                  children: [
                    Container(color: Colors.black12),
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: FadeInImage.memoryNetwork(
                        image: video.image!,
                        placeholder: kTransparentImage,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title ?? 'Без названия',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    BlankSpace.bottom(6),
                    Row(
                      children: [
                        const Icon(Icons.visibility, size: 14),
                        BlankSpace.right(4),
                        Text(
                          (video.views?.toString() ?? 'N/A'),
                        ),
                        BlankSpace.right(12),
                        const Icon(Icons.comment, size: 14),
                        BlankSpace.right(4),
                        Text((video.comments?.toString() ?? 'N/A')),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
