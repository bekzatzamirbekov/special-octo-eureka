import 'package:flutter/material.dart';
import 'package:mocked_mbank/components/text_span_widget.dart';
import 'package:mocked_mbank/models/credit_mbank.dart';
import 'package:shimmer/shimmer.dart';

import '../cubits/credit_cubit.dart';
import '../cubits/them_cubit.dart';
import 'credit_tile.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    required this.isLight,
    required this.themeCubit,
    required this.creditCubit,
  }) : super(key: key);

  final bool isLight;
  final ThemeCubit themeCubit;
  final CreditCubit creditCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLight ? const Color(0xFFEFF0F2) : Colors.black12,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Bekzat"),
        actions: [
          IconButton(
            icon: const Icon(Icons.lightbulb),
            onPressed: () {
              themeCubit.toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Shimmer.fromColors(
              baseColor: Color.fromARGB(255, 236, 233, 233),
              highlightColor: Color.fromARGB(255, 107, 131, 86),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.only(left: 20, bottom: 15, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    adaptiveSpan(context, "Product name: ", "Loading"),
                    adaptiveSpan(context, "Loan month: ", "Loading"),
                    adaptiveSpan(context, "Credit take date: ", "Loading"),
                    adaptiveSpan(context, "Credit amount: ", "Loading"),
                    adaptiveSpan(
                        context, "Total sum with percents: ", "Loading"),
                  ],
                ),
              ),
            ),
          ),

          // baseColor: Colors.white,
          // highlightColor: Colors.yellow,
          Expanded(
            child: Shimmer.fromColors(
              period: const Duration(seconds: 2),
              baseColor: Color.fromARGB(255, 236, 233, 233),
              highlightColor: Color.fromARGB(255, 107, 131, 86),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 12,
                          itemBuilder: (context, index) {
                            return CreditTile(
                              credit: CreditMbank(),
                              date: DateTime.now(),
                              onTileTap: () {
                                // Handle tile expansion and navigation to credit details screen
                              },
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Payment Day: Loading',
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                              subtitle: const Text('Payment Sum: Loading',
                                  style: TextStyle(fontSize: 16)),
                            );
                          },
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
