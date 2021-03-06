import 'package:flutter/material.dart';
import 'package:worktracker/helpers/responsive.dart';
import 'package:worktracker/widgets/home/PieChart.dart';

class DayGraph extends StatefulWidget {
  DayGraph({
    Key key,
    @required this.dayRoutines
  }) : super(key: key);

  final List<dynamic> dayRoutines;

  @override
  DayGraphState createState() => DayGraphState();
}

class DayGraphState extends State<DayGraph>
  with SingleTickerProviderStateMixin {
  double done;
  double undone;
  int total;
  Animation<double> _textAnimation;
  AnimationController _controllerAnimation;
  Tween<double> _tween;
  final GlobalKey<PieChartState> _pieChartGlobalKey
    = GlobalKey<PieChartState>();

  @override
  void initState() {
    super.initState();
    setData();

    _controllerAnimation = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this
    );

    _controllerAnimation.forward();

    _tween = Tween(begin: 0.0, end: done);
    _textAnimation = _tween.animate(_controllerAnimation);
  }

  void setData() {
    double doneCount = 0;
    double undoneCount = 0;
    List<dynamic> dayRoutines = widget.dayRoutines;
    for(Map<dynamic, dynamic> dayRoutine in dayRoutines) {
      if(dayRoutine['status'] == 2)
        doneCount++;
      else if(dayRoutine['status'] == 3)
        undoneCount++;
    }

    setState(() {
      done = doneCount;
      undone = undoneCount;
      if(dayRoutines.length > 0)
        total = dayRoutines.length;
    });

    final pieChartState = _pieChartGlobalKey.currentState;
    if(pieChartState != null) {
      _tween.begin = _tween.end;
      _controllerAnimation.reset();
      _tween.end = doneCount;
      _controllerAnimation.forward();
      pieChartState.setData(doneCount, undoneCount);
    }
  }

  String getPercentage() {
    if(total != null && total != 0)
      return '${(_textAnimation.value/total * 100).toInt()}%';
    else {
      return '0%';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.0,
      width: deviceWidth(context, 0.95),
      margin: EdgeInsets.symmetric(
        horizontal: deviceWidth(context, 0.025),
        vertical: deviceHeigth(context, 0.1)
      ),
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Stack(
          alignment: Alignment.center,
          children: [
            PieChart(
              key: _pieChartGlobalKey,
              done: done,
              undone: undone,
              total: total
            ),
            Container(
              width: deviceWidth(context, 0.16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white24, width: 0.5)
              ),
              child: AnimatedBuilder(
                animation: _controllerAnimation,
                builder: (context, child) => Text(
                  getPercentage(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: textSize(context, 19.0),
                    fontWeight: FontWeight.bold
                  )
                )
              )
            )
          ],
        )
      )
    );
  }
}
