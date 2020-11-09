/// Bar chart example
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// Example of a stacked bar chart with three series, each rendered with
/// different fill colors.
class BarChart extends StatelessWidget {
  final List<charts.Series> data;

  BarChart(this.data);

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      data,
      animate: false,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      // Hide domain axis.
      // domainAxis:
      //     new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),
      // Configure a stroke width to enable borders on the bars.
      defaultRenderer: new charts.BarRendererConfig(
        groupingType: charts.BarGroupingType.stacked,
        strokeWidthPx: 2.0,
        barRendererDecorator: new charts.BarLabelDecorator<String>(),
      ),
    );
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
// Can see the label
// barRendererDecorator: new charts.BarLabelDecorator<String>(),
//       // Hide domain axis.
//       domainAxis:
//           new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),

// for rotation
//  domainAxis: charts.OrdinalAxisSpec(
//               renderSpec: charts.SmallTickRendererSpec(labelRotation: 60),
//        ),
