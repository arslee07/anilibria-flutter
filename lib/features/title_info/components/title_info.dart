import 'package:anilibria/anilibria.dart' as anilibria;
import 'package:flutter/material.dart';

class TitleInfo extends StatelessWidget {
  final anilibria.Title model;
  const TitleInfo(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (model.season?.year != null)
          _InfoItem('Год: ', model.season!.year!.toString()),
        if (model.status?.string != null)
          _InfoItem('Статус: ', model.status!.string!),
        if (model.type?.fullString != null)
          _InfoItem('Тип: ', model.type!.fullString!),
        if ((model.genres ?? []).isNotEmpty)
          _InfoItem('Жанры: ', model.genres!.join(', ')),
        if ((model.team?.voice ?? []).isNotEmpty)
          _InfoItem('Озвучка: ', model.team!.voice!.join(', ')),
        if ((model.team?.translator ?? []).isNotEmpty)
          _InfoItem('Перевод: ', model.team!.translator!.join(', ')),
        if ((model.team?.editing ?? []).isNotEmpty)
          _InfoItem('Редактирование: ', model.team!.editing!.join(', ')),
        if ((model.team?.timing ?? []).isNotEmpty)
          _InfoItem('Тайминг: ', model.team!.timing!.join(', ')),
        if ((model.team?.decor ?? []).isNotEmpty)
          _InfoItem('Декор: ', model.team!.decor!.join(', ')),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const _InfoItem(this.title, this.subtitle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 15,
            ),
        children: <TextSpan>[
          TextSpan(
            text: title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: subtitle),
        ],
      ),
    );
  }
}
