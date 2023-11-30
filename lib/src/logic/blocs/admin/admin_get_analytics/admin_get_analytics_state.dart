part of 'admin_get_analytics_cubit.dart';

sealed class AdminGetAnalyticsState extends Equatable {
  const AdminGetAnalyticsState();

  @override
  List<Object> get props => [];
}

final class AdminGetAnalyticsLoadingS extends AdminGetAnalyticsState {}

final class AdminGetAnalyticsSuccessS extends AdminGetAnalyticsState {
  final List<Sales> sales;
  final int totalEarnings;
  final List<ColumnSeries<Sales, String>> seriesData;

  const AdminGetAnalyticsSuccessS(
      {required this.sales,
      required this.totalEarnings,
      required this.seriesData});
  @override
  List<Object> get props => [sales, totalEarnings, seriesData];
}

final class AdminGetAnalyticsErrorS extends AdminGetAnalyticsState {
  final String errorString;

  const AdminGetAnalyticsErrorS({required this.errorString});
  @override
  List<Object> get props => [errorString];
}
