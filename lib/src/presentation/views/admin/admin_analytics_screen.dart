import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_get_analytics/admin_get_analytics_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AdminAnalyticsScreen extends StatelessWidget {
  const AdminAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AdminGetAnalyticsCubit>().adminGetAnalytics();

    return SingleChildScrollView(
      child: BlocConsumer<AdminGetAnalyticsCubit, AdminGetAnalyticsState>(
        listener: (context, state) {
          if (state is AdminGetAnalyticsErrorS) {
            showSnackBar(context, state.errorString);
          }
        },
        builder: (context, state) {
          if (state is AdminGetAnalyticsLoadingS) {
            return SizedBox(
              height: MediaQuery.sizeOf(context).height / 1.2,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is AdminGetAnalyticsSuccessS) {
            return Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Total Earnings - ₹${formatLakhs(state.totalEarnings)}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.7,
                    width: double.infinity,
                    child: SfCartesianChart(
                      primaryXAxis: const CategoryAxis(
                        labelRotation: 270,
                        majorGridLines: MajorGridLines(width: 0),
                      ),
                      primaryYAxis: NumericAxis(
                        isVisible: true,
                        placeLabelsNearAxisLine: true,
                        numberFormat: NumberFormat.compact(locale: 'en_IN'),
                        // labelRotation: 270,
                        minimum: 0,
                        maximum: (state.totalEarnings * 3),
                        majorGridLines: const MajorGridLines(width: 0.5),
                      ),
                      series: state.seriesData,
                    ),
                  ),
                ),
              ],
            );
          }
          return SizedBox(
            height: MediaQuery.sizeOf(context).height / 1.2,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
