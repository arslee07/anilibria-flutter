import 'package:anilibria/anilibria.dart' as anilibria;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

class TitleSeries extends StatelessWidget {
  final anilibria.Title model;
  const TitleSeries(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverStack(
      children: [
        const SliverPositioned.fill(child: Card()),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final serie = model.player!.playlist!.reversed.elementAt(index);
              return ListTile(
                title: Text('Серия ' + serie.serie.toString()),
                trailing: Wrap(
                  children: [
                    if ((serie.hls?.fhd ?? '').isNotEmpty)
                      TextButton(
                        onPressed: () => context.push(
                          '/player?q=${Uri.encodeFull(serie.hls!.fhd!)}',
                        ),
                        child: const Text(
                          'FHD',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    if ((serie.hls?.hd ?? '').isNotEmpty)
                      TextButton(
                        onPressed: () => context.push(
                          '/player?q=${Uri.encodeFull(serie.hls!.hd!)}',
                        ),
                        child: const Text(
                          'HD',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    if ((serie.hls?.sd ?? '').isNotEmpty)
                      TextButton(
                        onPressed: () => context.push(
                          '/player?q=${Uri.encodeFull(serie.hls!.sd!)}',
                        ),
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
              );
            },
            childCount: model.player!.playlist!.length,
          ),
        ),
      ],
    );
  }
}
