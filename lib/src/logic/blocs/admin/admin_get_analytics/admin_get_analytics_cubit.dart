import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/sales.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/admin_repository.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

part 'admin_get_analytics_state.dart';

class AdminGetAnalyticsCubit extends Cubit<AdminGetAnalyticsState> {
  final AdminRepository adminRepository;
  AdminGetAnalyticsCubit(this.adminRepository)
      : super(AdminGetAnalyticsLoadingS());

  Future<void> adminGetAnalytics() async {
    try {
      Map<String, dynamic> earnings;
      List<ColumnSeries<Sales, String>> seriesData;

      emit(AdminGetAnalyticsLoadingS());

      earnings = await adminRepository.adminGetAnalytics();

      seriesData = [
        ColumnSeries<Sales, String>(
          dataSource: earnings['sales'],
          xValueMapper: (Sales data, _) => data.label,
          yValueMapper: (Sales data, _) => data.earning,
          pointColorMapper: (Sales data, _) => data.pointColor,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        )
      ];

      emit(AdminGetAnalyticsSuccessS(
          sales: earnings['sales'],
          totalEarnings: earnings['totalEarnings'],
          seriesData: seriesData));
    } catch (e) {
      emit(AdminGetAnalyticsErrorS(errorString: e.toString()));
    }
  }
}
