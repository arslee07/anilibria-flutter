import 'package:flutter/material.dart';
import 'package:anilibria/anilibria.dart' as anilibria;

class TitleSchedule extends StatelessWidget {
  final anilibria.Title model;
  const TitleSchedule(this.model, {Key? key}) : super(key: key);

  static const _days = ['ПН', 'ВТ', 'СР', 'ЧТ', 'ПТ', 'СБ', 'ВС'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (model.season?.weekDay != null &&
            model.status?.code == anilibria.TitleStatusCode.inWork) ...[
          Wrap(
            spacing: 4,
            alignment: WrapAlignment.center,
            children: [
              for (int i = 0; i < 7; i++)
                WeekDayItem(_days[i], model.season?.weekDay == i)
            ],
          ),
        ],
        if (model.announce != null) ...[
          const SizedBox(height: 6),
          Text(
            model.announce!,
          ),
        ],
      ],
    );
  }
}

class WeekDayItem extends StatelessWidget {
  final String day;
  final bool active;
  const WeekDayItem(this.day, this.active, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activeColor = Theme.of(context).colorScheme.primary;
    final inactiveColor = Theme.of(context).disabledColor;

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Text(
          day,
          style: TextStyle(
            color: active ? Colors.white : inactiveColor,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border:
            Border.all(width: 1, color: active ? activeColor : inactiveColor),
        color: active ? activeColor : null,
      ),
    );
  }
}
