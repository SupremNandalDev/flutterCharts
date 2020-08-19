import 'package:charts_demo/providers/myProvider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyProvider>(
        create: (context) => MyProvider(),
      child: Consumer<MyProvider>(
        builder: (context,provider,child){
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Flutter charts demo'),
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: (){
                    provider.addDataToList();
                  },
                )
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: provider.list.map((data) =>
                      data.getView(
                        onClick: () async{
                          DateTime dateTime = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2011),
                            lastDate: DateTime(2021)
                          );
                          if(dateTime==null)
                            return;
                          provider.setDateOnData(data,dateTime);
                        }
                      )
                    ).toList(),
                  ),
                ),
                FlatButton(
                  onPressed: (){
                    provider.buildGraphData();
                  },
                  child: Text('Show Data'),
                ),
                if(provider.timeSeries!=null && provider.pieSeries!=null)
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: charts.TimeSeriesChart(
                          provider.timeSeries,
                          defaultRenderer: charts.BarRendererConfig<DateTime>(),
                        ),
                      ),
                      Expanded(
                        child: charts.PieChart(
                          provider.pieSeries
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
