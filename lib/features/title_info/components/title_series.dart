import 'package:anilibria/anilibria.dart' as anilibria;
import 'package:flutter/material.dart';

class TitleSeries extends StatelessWidget {
  final anilibria.Title model;
  const TitleSeries(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView.builder(
        itemBuilder: (context, index) {
          final playlist = model.player!.playlist![index];

          return ListTile(
            title: Text('Серия ' + playlist.serie.toString()),
            trailing: Wrap(
              children: [
                if ((playlist.hls?.fhd ?? '').isNotEmpty)
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'FHD',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                if ((playlist.hls?.hd ?? '').isNotEmpty)
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'HD',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                if ((playlist.hls?.sd ?? '').isNotEmpty)
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'SD',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
              ],
            ),
            tileColor: index % 2 == 0 ? const Color.fromARGB(8, 0, 0, 0) : null,
          );
        },
        itemCount: model.player!.playlist!.length,
        shrinkWrap: true,
      ),
    );
  }
}
