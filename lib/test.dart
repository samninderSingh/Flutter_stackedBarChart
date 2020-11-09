/// Horizontal bar chart with custom style for each datum in the bar label.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class HorizontalBarLabelCustomChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  HorizontalBarLabelCustomChart(this.seriesList, {this.animate});

  // The [BarLabelDecorator] has settings to set the text style for all labels
  // for inside the bar and outside the bar. To be able to control each datum's
  // style, set the style accessor functions on the series.
  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      // Hide domain axis.
      domainAxis:
          new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),
    );
  }
}

/// Sample ordinal data type.
class OrdinalSalesTest {
  final String year;
  final int sales;

  OrdinalSalesTest(this.year, this.sales);
}
