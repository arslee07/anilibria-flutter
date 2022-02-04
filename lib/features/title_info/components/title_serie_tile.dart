import 'package:anilibria/anilibria.dart' as anilibria;
import 'package:anilibria_app/utils/get_title_name.dart';
import 'package:anilibria_app/utils/player_title_info.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TitleSerieTile extends StatelessWidget {
  final anilibria.Title title;
  final anilibria.Serie serie;
  const TitleSerieTile(this.title, this.serie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Серия ' + serie.serie.toString()),
      trailing: Wrap(
        children: [
          if ((serie.hls?.fhd ?? '').isNotEmpty)
            TextButton(
              onPressed: () => context.push(
                GoRouter.of(context).location + '/player',
                extra: PlayerTitleInfo(
                  serie.hls!.fhd!,
                  getTitleName(title),
                  serie.serie!,
                ),
              ),
              child: const Text(
                'FHD',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          if ((serie.hls?.hd ?? '').isNotEmpty)
            TextButton(
              onPressed: () => context.push(
                GoRouter.of(context).location + '/player',
                extra: PlayerTitleInfo(
                  serie.hls!.hd!,
                  getTitleName(title),
                  serie.serie!,
                ),
              ),
              child: const Text(
                'HD',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          if ((serie.hls?.sd ?? '').isNotEmpty)
            TextButton(
              onPressed: () => context.push(
                GoRouter.of(context).location + '/player',
                extra: PlayerTitleInfo(
                  serie.hls!.sd!,
                  getTitleName(title),
                  serie.serie!,
                ),
              ),
              child: const Text(
                'SD',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
      tileColor:
          serie.serie! % 2 == 0 ? const Color.fromARGB(128, 0, 0, 0) : null,
    );
  }
}
