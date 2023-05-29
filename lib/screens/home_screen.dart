import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../components/credit_tile.dart';
import '../components/loading_widget.dart';
import '../components/text_span_widget.dart';
import '../cubits/credit_cubit.dart';
import '../cubits/them_cubit.dart';
import '../main.dart';
import '../models/credit_mbank.dart';
import '../utils/theme_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String title = "";
  int foos = 0;
  int? _key;
  int _expandedIndex = -1;

  _collapse() {
    int? newKey;
    do {
      _key = new Random().nextInt(10000);
    } while (newKey == _key);
  }

  @override
  void initState() {
    super.initState();
    _collapse();
  }

  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    final CreditCubit creditCubit = BlocProvider.of<CreditCubit>(context);
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    var isLight = Theme.of(context).brightness == Brightness.light;

    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final tileColor = isLightTheme ? Colors.white : Colors.black;
    return Scaffold(
      body: BlocBuilder<CreditCubit, CreditState>(
        builder: (context, state) {
          if (state.isLoading) {
            return LoadingWidget(
                isLight: isLight,
                themeCubit: themeCubit,
                creditCubit: creditCubit);
          } else if (state.errorMessage.isNotEmpty &&
              state.errorMessage != "") {
            return Center(
              child: Text('Error: ${state.errorMessage}'),
            );
          } else if (state.credits.isEmpty) {
            return const Center(
              child: Text('No credits available.'),
            );
          } else {
            final List<CreditMbank> credits = state.credits;

            final title = credits.first.productName!;

            final int paymentDays = credits.first.paymentDay!;

            final List<Widget> paymentTiles = [];
            final int totalAmount = credits.first
                .amount!; // Assuming a fixed total amount for demonstration purposes

            final takeDate =
                DateFormat('dd.MM.yyyy').parse(credits.first.takeDate!);

            List<DateTime> calculateNextDates(
                DateTime startDate, int count, List<String> holidays) {
              final nextDates = <DateTime>[];
              var currentDate = startDate;

              for (var i = 0; i < count; i++) {
                if (holidays.contains(formatDate(currentDate))) {
                  DateTime nextDate = DateTime(
                      currentDate.year, currentDate.month, currentDate.day + 1);
                  if (holidays.contains(formatDate(nextDate))) {
                    nextDates.add(DateTime(currentDate.year, currentDate.month,
                        currentDate.day + 2));
                  } else {
                    nextDates.add(DateTime(currentDate.year, currentDate.month,
                        currentDate.day + 1));
                  }
                  currentDate = DateTime(
                      currentDate.year, currentDate.month + 1, currentDate.day);
                } else {
                  nextDates.add(currentDate);
                  currentDate = DateTime(
                      currentDate.year, currentDate.month + 1, currentDate.day);
                }
              }

              return nextDates;
            }

            final credit = state.credits;

            DateTime currentDate =
                DateTime(takeDate.year, takeDate.month + 1, paymentDays);
            var holidays = state.credits.first.holidays;
            var loanMonth = state.credits.first.loanMonths;
            var paymentDay = state.credits.first.paymentDay;
            final nextDates =
                calculateNextDates(currentDate, loanMonth!, holidays!);
            final paymentSum =
                ((totalAmount * (1 + credit.first.percent! / 100)) /
                        credit.first.loanMonths!)
                    .toStringAsFixed(1);
            for (int index = 0; index < nextDates.length; index++) {
              Widget _collapseTile(Widget paymentTil) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _expandedIndex = index;
                        });
                      },
                      child: Text('Pay  $paymentSum'),
                    ),
                  ),
                );
              }

              final date = nextDates[index];
              paymentTiles.add(Padding(
                padding: const EdgeInsets.all(6.0),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.zero,
                  child: ExpansionTile(
                    backgroundColor: tileColor,
                    title: Text(
                      'Sum: $paymentSum USD',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      'Date: ${DateFormat('dd').format(date)} ${DateFormat('MMMM').format(date)} ${DateFormat('yyyy').format(date)}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_down_rounded),
                    childrenPadding: EdgeInsets.zero,
                    collapsedBackgroundColor: tileColor,
                    expandedAlignment: Alignment.centerLeft,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    leading: CircleAvatar(
                      backgroundColor: myColor,
                      child: const Icon(Icons.attach_money_rounded,
                          color: Colors.white),
                    ),
                    children: [
                      if (_expandedIndex == index) _collapseTile(Container()),
                    ],
                    onExpansionChanged: (isExpanded) {
                      setState(() {
                        if (isExpanded) {
                          // close previously expanded tile
                          if (_expandedIndex != -1) {
                            paymentTiles[_expandedIndex] =
                                _collapseTile(paymentTiles[_expandedIndex]);
                          }
                          _expandedIndex = index;
                        } else {
                          _expandedIndex = -1;
                        }
                      });
                    },
                  ),
                ),
              ));
            }

            return Scaffold(
              backgroundColor:
                  isLight ? const Color(0xFFEFF0F2) : Colors.black12,
              appBar: AppBar(
                backgroundColor:isLight ? Color(0xFF009987) : Colors.black12,
                elevation: 0,
                centerTitle: true,
                title: const Text("Bekzat", style: TextStyle(color: Colors.white),),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.lightbulb, color: Colors.white,),
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: isLight ? Colors.white : Colors.black12,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding:
                          const EdgeInsets.only(left: 20, bottom: 15, top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          adaptiveSpan(context, "Product name: ", title),
                          adaptiveSpan(
                              context, "Loan month: ", "$loanMonth month"),
                          adaptiveSpan(context, "Payment day: ",
                              "${paymentDay}th(if not holiday)"),
                          adaptiveSpan(context, "Credit take date: ",
                              formatDate(takeDate).toString()),
                          adaptiveSpan(context, "Credit amount: ",
                              "$totalAmount ${credits.first.currency}"),
                          adaptiveSpan(
                            context,
                            "Total sum with percents: ",
                            "${(totalAmount * (1 + credit.first.percent! / 100)).round()} ${credits.first.currency}",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: paymentTiles,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFFBC00),
        onPressed: () {
          creditCubit.fetchCredits();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

String formatDate(DateTime date) {
  return DateFormat('dd.MM.yyyy').format(date);
}



              //   CreditTile(
              //   credit: credit.first,
              //   date: currentDate,
              //   onTileTap: () {
              //     // Handle tile expansion and navigation to credit details screen
              //   },
              //   subtitle: Text(
              //       'Date: ${DateFormat('dd').format(date)} ${DateFormat('MMMM').format(date)} ${DateFormat('yyyy').format(date)}',
              //       style: const TextStyle(fontSize: 16, fontWeight:FontWeight.w500)),
              //   title: Text(
              //     'Sum: $paymentSum USD',
              //     style: const TextStyle(fontSize: 18, fontWeight:FontWeight.w700 ),
              //   ),
              // )