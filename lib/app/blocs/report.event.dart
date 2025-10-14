

import 'package:flutter_advanced_2025/app/model/report.model.dart';

abstract class ReportEvent {}

class AddReport extends ReportEvent{
  final Report report;
  AddReport(this.report);
}
