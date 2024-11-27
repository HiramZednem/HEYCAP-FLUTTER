import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraficaScreen extends StatelessWidget {
  final List<Map<String, dynamic>> historicalData = [
    {"vistas": 21, "fecha": "2024-11-10"},
    {"vistas": 9, "fecha": "2024-11-11"},
    {"vistas": 7, "fecha": "2024-11-12"},
    {"vistas": 14, "fecha": "2024-11-13"},
    {"vistas": 14, "fecha": "2024-11-14"},
    {"vistas": 15, "fecha": "2024-11-15"},
    {"vistas": 6, "fecha": "2024-11-16"},
  ];

  final List<Map<String, dynamic>> predictedRows = [
    {"vistas": 8, "fecha": "2024-11-17"},
    {"vistas": 7, "fecha": "2024-11-18"},
    {"vistas": 6, "fecha": "2024-11-19"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grafica de Vistas'),
      ),
      body: SfCartesianChart(
        primaryXAxis: DateTimeAxis(),
        title: ChartTitle(text: 'Vistas Historicas y Predicciones'),
        legend: Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries>[
          LineSeries<Map<String, dynamic>, DateTime>(
            name: 'Historico',
            dataSource: historicalData,
            xValueMapper: (Map<String, dynamic> data, _) =>
                DateTime.parse(data['fecha']),
            yValueMapper: (Map<String, dynamic> data, _) => data['vistas'],
            dataLabelSettings: DataLabelSettings(isVisible: true),
          ),
          LineSeries<Map<String, dynamic>, DateTime>(
            name: 'Prediccion',
            dataSource: predictedRows,
            xValueMapper: (Map<String, dynamic> data, _) =>
                DateTime.parse(data['fecha']),
            yValueMapper: (Map<String, dynamic> data, _) => data['vistas'],
            dataLabelSettings: DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GraficaScreen(),
  ));
}