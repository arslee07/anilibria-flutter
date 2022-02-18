import 'package:anilibria_app/utils/config.dart';
import 'package:anilibria_app/utils/widgets/blank_space.dart';
import 'package:flutter/material.dart';
import 'package:anilibria/anilibria.dart' as anilibria;
import 'package:url_launcher/url_launcher.dart';

class TitleTorrentTile extends StatelessWidget {
  final anilibria.Torrent torrent;
  const TitleTorrentTile(this.torrent, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: () {
          launch(kStaticUrl.toString() + torrent.url!);
        },
        title: Text(
          'Серия ${torrent.series?.string ?? "N/A"} (${torrent.quality?.string ?? "N/A"})',
        ),
        trailing: const Icon(Icons.download),
        subtitle: Row(
          children: [
            Text(
              ((torrent.totalSize ?? 0) / 1024 / 1024 / 1024)
                      .toStringAsFixed(1) +
                  ' GB',
            ),
            BlankSpace.right(6),
            const Icon(
              Icons.file_upload_outlined,
              size: 16,
              color: Colors.green,
            ),
            Text((torrent.seeders ?? 0).toString()),
            BlankSpace.right(6),
            const Icon(
              Icons.file_download_outlined,
              size: 16,
              color: Colors.red,
            ),
            Text((torrent.leechers ?? 0).toString()),
          ],
        ),
      ),
    );
  }
}
