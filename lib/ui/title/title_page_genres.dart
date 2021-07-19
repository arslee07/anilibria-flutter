import 'package:anilibria/model/title_model.dart';
import 'package:flutter/material.dart';

class TitlePageGenres extends StatelessWidget {
  final TitleModel model;
  const TitlePageGenres({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Жанры',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(padding: EdgeInsets.only(bottom: 8)),
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              for (int i = 0; i < model.genres.length; i++)
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 4, 4),
                  child: ActionChip(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    label: Text(model.genres[i]),
                    onPressed: () {},
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
