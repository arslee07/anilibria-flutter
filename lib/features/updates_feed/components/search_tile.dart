import 'package:anilibria/anilibria.dart' as anilibria;
import 'package:anilibria_app/utils/config.dart';
import 'package:anilibria_app/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:transparent_image/transparent_image.dart';

class SearchTile extends StatelessWidget {
  final anilibria.Title model;
  const SearchTile(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Routemaster.of(context).push('/titles/${model.id!}'),
      child: Container(
        color: Theme.of(context).listTileTheme.tileColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: 350 / 10,
                height: 550 / 10,
                child: Hero(
                  tag: model.id!,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: kStaticUrl.toString() + (model.poster?.url ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              BlankSpace.right(8),
              Expanded(
                child: Text(
                  model.names?.ru ??
                      model.names?.alternative ??
                      model.names?.en ??
                      '[Без навзвания]',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
