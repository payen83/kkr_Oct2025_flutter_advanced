import 'package:flutter/material.dart';
import 'package:flutter_advanced_2025/app/blocs/report.bloc.dart';
import 'package:flutter_advanced_2025/app/blocs/report.state.dart';
import 'package:flutter_advanced_2025/app/constant/color.constant.dart';
import 'package:flutter_advanced_2025/app/view/addreport.page.dart';
import 'package:flutter_advanced_2025/app/widget/drawer.widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportListPage extends StatelessWidget {
  const ReportListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Report List'),
      ),
      drawer: DrawerWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddReportPage()));
        },
        foregroundColor: kShrineSurfaceWhite,
        backgroundColor: kShrinePink400,
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<ReportBloc, ReportState>(builder: (context, state){
        return ListView.builder(
          itemCount: state.reports.length,
          itemBuilder: (context, index){
            final report = state.reports[index];
            return Container(
              margin: EdgeInsets.fromLTRB(16,16,16,0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black)
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 3),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      report.title,
                      style: theme.textTheme.titleLarge
                    ), 
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 3),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      report.description,
                      style: theme.textTheme.bodyMedium
                    ), 
                  )
                ],
              ),
            );
          },
        );
      }),
    );
  }
}