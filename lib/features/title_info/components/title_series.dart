import 'package:anilibria/anilibria.dart' as anilibria;
import 'package:flutter/material.dart';

class TitleSeries extends StatelessWidget {
  final anilibria.Title model;
  const TitleSeries(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          for (final serie in model.player!.playlist!.reversed)
            ListTile(
              title: Text('Серия ' + serie.serie.toString()),
              trailing: Wrap(
                children: [
                  if ((serie.hls?.fhd ?? '').isNotEmpty)
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'FHD',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  if ((serie.hls?.hd ?? '').isNotEmpty)
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'HD',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  if ((serie.hls?.sd ?? '').isNotEmpty)
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'SD',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                ],
              ),
              tileColor: serie.serie! % 2 == 0
                  ? const Color.fromARGB(8, 0, 0, 0)
                  : null,
            ),
        ],
      ),
    );
  }
}
