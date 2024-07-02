import 'package:date_format/date_format.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../forms/theme.dart';
import '../model/GraphResponseModel.dart';


class Sleeplinegraph extends StatelessWidget {
  final List<GraphResponseModel> StressList;
  final List<LineChartBarData> linesChart;

  Sleeplinegraph({super.key, required this.StressList, required this.linesChart});

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Obx(()=> Row(
          // mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Padding(
               padding: const EdgeInsets.all(8),
               child: LegendItem(color:AppTheme.appBlueColor, text: 'Deep Sleep'),
             ),
             Padding(
               padding: const EdgeInsets.all(8),

               child: LegendItem(color:AppTheme.appgreenColor, text: 'Efficiency'),
             ),
             Padding(
               padding: const EdgeInsets.all(8),

               child: LegendItem(color:AppTheme.appGreyColor, text: 'Latency'),
             ),
             Padding(
               padding: const EdgeInsets.all(8),

               child: LegendItem(color:AppTheme.appYellowColor, text: 'Rem Sleep'),
             ),
             // SizedBox(height: 20),
             Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8),

                   child: LegendItem(color:AppTheme.appPurpleColor, text: 'Restfulness'),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8),

                   child: LegendItem(color:AppTheme.appOrangeColor, text: 'Timing'),
                 ),
               ],
             ),
             // SizedBox(height: 20),
             Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8),

                   child: LegendItem(color: AppTheme.appDeepPurpleColor, text: 'Total Sleep'),
                 ),
               ],
             ),
             // SizedBox(height: 20),
           ],
         )),
        SizedBox(height: 20),
        Container(
          width: StressList.length < 8?width*1.2 :StressList.length* 40.0,
          height: height*0.6,
          child: LineChart(
            LineChartData(
              lineBarsData: linesChart,
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final day = value.toInt() ;
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        space: 8.0,
                        child: Text((day + 1).toString() ,
                            style: TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.w400)),
                      );

                    },
                    interval: 1,
                    reservedSize: 40,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 50,
                    getTitlesWidget: (value, meta) {
                      final left = value.toInt();
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        space: 8.0,
                        child: Text(left == 0 ? 'Ratio $left' : left.toString(),
                            style: const TextStyle(
                                fontSize: 10, color: Colors.black)),
                      );
                    },
                    interval: 10,
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
      ],
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
