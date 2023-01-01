import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_chart/charts/line-chart.widget.dart';
import 'package:line_chart/model/line-chart.model.dart';

import '../../../../../utils/color_manager.dart';
import '../../../../../utils/image_manager.dart';

class CustomCoinCard extends StatelessWidget {
  String? coinName;
  String? coinRate;
  String? coinPrice;
  String? coinPercent;
  String? coinPicture;
  Color? cardColor;
  CustomCoinCard(
      {Key? key,
      this.coinName,
      this.coinPercent,
      this.coinPrice,
      this.cardColor,
      this.coinPicture,
      this.coinRate})
      : super(key: key);
  List<LineChartModel> data = [
    LineChartModel(amount: 100, date: DateTime(2020, 1, 1)),
    LineChartModel(amount: 200, date: DateTime(2020, 1, 2)),
    LineChartModel(amount: 300, date: DateTime(2020, 1, 3)),
    LineChartModel(amount: 400, date: DateTime(2020, 1, 4)),
    LineChartModel(amount: 800, date: DateTime(2020, 1, 5)),
    LineChartModel(amount: 200, date: DateTime(2020, 1, 6)),
    LineChartModel(amount: 140, date: DateTime(2020, 1, 8)),
    LineChartModel(amount: 110, date: DateTime(2020, 1, 9)),
    LineChartModel(amount: 250, date: DateTime(2020, 1, 10)),
    LineChartModel(amount: 390, date: DateTime(2020, 1, 11)),
    LineChartModel(amount: 900, date: DateTime(2020, 1, 12)),
  ];
  @override
  Widget build(BuildContext context) {
    Paint circlePaint = Paint()..color = Colors.black;

    Paint insideCirclePaint = Paint()..color = Colors.white;

    Paint linePaint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..color = ColorsManager.WHITE_COLOR;
    return Container(
      height: 126,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r), color: cardColor),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                coinName!,
                style: TextStyle(color: ColorsManager.WHITE_COLOR),
              ),
              CircleAvatar(
                radius: 10,
                backgroundColor: ColorsManager.WHITE_COLOR,
                child: Image.asset(
                  coinPicture!,
                  height: 16,
                ),
              )
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              coinRate!,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: ColorsManager.WHITE_COLOR,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp),
            ),
          ),
          LineChart(
            width: 100,
            height: 30,
            data: data,
            linePaint: linePaint,
            showPointer: true,
            showCircles: false,
            linePointerDecoration: BoxDecoration(
              color: ColorsManager.WHITE_COLOR,
            ),
            pointerDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsManager.WHITE_COLOR,
            ),
            insideCirclePaint: insideCirclePaint,
            onValuePointer: (LineChartModelCallback value) {
              print('${value.chart} ${value.percentage}');
            },
            onDropPointer: () {
              print('onDropPointer');
            },
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                coinPrice!,
                style: TextStyle(color: ColorsManager.WHITE_COLOR),
              ),
              Text(
                "$coinPercent\%",
                style: TextStyle(color: ColorsManager.WHITE_COLOR),
              ),
            ],
          )
        ],
      ),
    );
  }
}
