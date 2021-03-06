import 'package:flutter/material.dart';
import 'package:worktracker/helpers/responsive.dart';

class DayCard extends StatefulWidget {
  final bool active;
  final Map<String, dynamic> day;

  DayCard({
    Key key,
    @required this.active,
    @required this.day
  }) : super(key: key);

  @override
  _DayCardState createState() => _DayCardState();
}

class _DayCardState extends State<DayCard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: deviceWidth(context, 0.1658),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: widget.active ? Color(0xFF1A4F95) : Colors.black.withOpacity(0.2)
      ),
      duration: Duration(milliseconds: 300),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.day['day'],
            style: TextStyle(
              color: Colors.white,
              fontSize: textSize(context, 26.0),
              fontWeight: FontWeight.bold
            )
          ),
          Text(
            widget.day['weekday'],
            style: TextStyle(
              color: Colors.white70,
              fontSize: textSize(context, 15.0)
            )
          )
        ],
      )
    );
  }
}
