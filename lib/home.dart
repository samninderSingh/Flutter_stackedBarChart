import 'package:barchart/barChart.dart';
import 'package:barchart/doubleLineChart.dart';
import 'package:barchart/subscriber_series.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'barChart.dart';

class HomePage extends StatelessWidget {
  final List<SubscriberSeries> data = [
    SubscriberSeries(
      year: "2008",
      subscribers: 100000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SubscriberSeries(
      year: "2009",
      subscribers: 200000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SubscriberSeries(
      year: "2010",
      subscribers: 300000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SubscriberSeries(
      year: "2011",
      subscribers: 350000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    )
  ];

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('Iteration 1', 5),
      new OrdinalSales('Iteration 2', 3),
      new OrdinalSales('Iteration 3', 6),
      new OrdinalSales('Iteration 4', 9),
    ];

    final tableSalesData = [
      new OrdinalSales('Iteration 1', 1),
      new OrdinalSales('Iteration 2', 2),
      new OrdinalSales('Iteration 3', 1),
      new OrdinalSales('Iteration 4', 3),
    ];

    // final mobileSalesData = [
    //   new OrdinalSales('2014', 10),
    //   new OrdinalSales('2015', 50),
    //   new OrdinalSales('2016', 50),
    //   new OrdinalSales('2017', 45),
    // ];

    return [
      // Solid red bars. Fill color will default to the series color if no
      // fillColorFn is configured.
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        // Set a label accessor to control the text of the bar label.
        labelAccessorFn: (OrdinalSales sales, _) => '${sales.sales} failed',
      ),
      // Blue bars with a lighter center color.
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        fillColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
        // Set a label accessor to control the text of the bar label.
        labelAccessorFn: (OrdinalSales sales, _) => '${sales.sales} success',
      ),
      // Hollow green bars.
      // new charts.Series<OrdinalSales, String>(
      //   id: 'Mobile',
      //   domainFn: (OrdinalSales sales, _) => sales.year,
      //   measureFn: (OrdinalSales sales, _) => sales.sales,
      //   data: mobileSalesData,
      //   colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      //   fillColorFn: (_, __) => charts.MaterialPalette.transparent,
      // ),
    ];
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSelectionData() {
    final us_data = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 48),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 38),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 74),
    ];

    final uk_data = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 15),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 66),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 28),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 58),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Response time 1',
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: us_data,
      ),
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Response time 2',
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: uk_data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 800,
        padding: EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(0.8),
          child: Column(
            children: [
              Text(
                "Total Success/failures",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Expanded(
                child: BarChart(_createSampleData()),
                // child: HorizontalBarLabelCustomChart(_createSampleDataTest()),
              ),
              Container(
                // margin: const EdgeInsets.only(top: 0),
                child: Text(
                  "Response time line chart",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              Expanded(
                child: SelectionCallbackExample(_createSelectionData()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
