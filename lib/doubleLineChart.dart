import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SelectionCallbackExample extends StatefulWidget {
  final List<charts.Series> seriesList;

  SelectionCallbackExample(this.seriesList);

  // We need a Stateful widget to build the selection details with the current
  // selection as the state.
  @override
  State<StatefulWidget> createState() => new _SelectionCallbackState();
}

class _SelectionCallbackState extends State<SelectionCallbackExample> {
  DateTime _time;
  Map<String, num> _measures;

  // Listens to the underlying selection changes, and updates the information
  // relevant to building the primitive legend like information under the
  // chart.
  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    DateTime time;
    final measures = <String, num>{};

    // We get the model that updated with a list of [SeriesDatum] which is
    // simply a pair of series & datum.
    //
    // Walk the selection updating the measures map, storing off the sales and
    // series name for each selection point.
    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum.time;
      selectedDatum.forEach((charts.SeriesDatum datumPair) {
        measures[datumPair.series.displayName] = datumPair.datum.sales;
      });
    }

    // Request a build.
    setState(() {
      _time = time;
      _measures = measures;
    });
  }

  @override
  Widget build(BuildContext context) {
    // The children consist of a Chart and Text widgets below to hold the info.
    final children = <Widget>[
      new SizedBox(
          height: 150.0,
          child: new charts.TimeSeriesChart(
            widget.seriesList,
            animate: false,
            selectionModels: [
              new charts.SelectionModelConfig(
                type: charts.SelectionModelType.info,
                changedListener: _onSelectionChanged,
              )
            ],
          )),
    ];

    // If there is a selection, then include the details.
    if (_time != null) {
      children.add(new Padding(
          padding: new EdgeInsets.only(top: 5.0),
          child: new Text(_time.toString())));
    }
    _measures?.forEach((String series, num value) {
      children.add(new Text('${series}: ${value}'));
    });

    return new Column(children: children);
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
