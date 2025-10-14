import 'package:flutter_advanced_2025/app/blocs/report.event.dart';
import 'package:flutter_advanced_2025/app/blocs/report.state.dart';
import 'package:flutter_advanced_2025/app/model/report.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc():super(ReportState(reports: [])){
    on<AddReport>((event, emit) {
      final updatedList = List<Report>.from(state.reports)..add(event.report);
      emit(ReportState(reports: updatedList));
    });
  }
}