import 'package:anilibria/anilibria.dart';
import 'package:anilibria_app/utils/config.dart';
import 'package:anilibria_app/utils/widgets/blank_space.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class YoutubeItem extends StatelessWidget {
  const YoutubeItem({
    required this.video,
    Key? key,
  }) : super(key: key);

  final Youtube video;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: InkWell(
        onTap: video.youtubeId == null
            ? null
            : () => launch(kYoutubeUrl.toString() + video.youtubeId!),
        child: SizedBox(
          height: ResponsiveValue(
            context,
            defaultValue: 1920 / 21.5,
            valueWhen: const [
              Condition.largerThan(name: MOBILE, value: 1920 / 16),
              Condition.largerThan(name: TABLET, value: 1920 / 14),
            ],
          ).value,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16 / 9,
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 12.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          HtmlUnescape().convert(video.title ?? 'Без названия'),
                          style: const TextStyle(fontSize: 16),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      BlankSpace.bottom(4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
      ),
    );
  }
}

class YoutubeItemMobile extends StatelessWidget {
  const YoutubeItemMobile({
    required this.video,
    Key? key,
  }) : super(key: key);

  final Youtube video;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: InkWell(
        onTap: video.youtubeId == null
            ? null
            : () => launch(kYoutubeUrl.toString() + video.youtubeId!),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 9,
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
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    HtmlUnescape().convert(video.title ?? 'Без названия'),
                    style: const TextStyle(fontSize: 16),
                    overflow: TextOverflow.fade,
                  ),
                  BlankSpace.bottom(6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
          ],
        ),
      ),
    );
  }
}
