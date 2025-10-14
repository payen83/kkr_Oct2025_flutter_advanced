import 'package:flutter/material.dart';
import 'package:flutter_advanced_2025/app/blocs/report.bloc.dart';
import 'package:flutter_advanced_2025/app/blocs/report.event.dart';
import 'package:flutter_advanced_2025/app/constant/color.constant.dart';
import 'package:flutter_advanced_2025/app/model/report.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddReportPage extends StatelessWidget {
  AddReportPage({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report List'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              width: MediaQuery.of(context).size.width,
              child: const Text('Title', style: TextStyle(fontSize: 14),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter title'
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              width: MediaQuery.of(context).size.width,
              child: const Text('Description', style: TextStyle(fontSize: 14),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: TextField(
                controller: descController,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter description'
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => saveReport(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: kShrinePink400,
                foregroundColor: kShrineSurfaceWhite,
                textStyle: TextStyle(fontSize: 20)
              ), 
              child: const Text('Save Report')
            )
          ],
        ),
      ),
    );
  }

 saveReport(BuildContext context){
    // print(titleController.text);
    // print(descController.text);

    final report = Report(title: titleController.text, description: descController.text);
    context.read<ReportBloc>().add(AddReport(report));
    Navigator.pop(context);
  }
 

}

