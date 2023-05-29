// To parse this JSON data, do
//
//     final creditMbank = creditMbankFromMap(jsonString);

import 'dart:convert';

CreditMbank creditMbankFromMap(String str) => CreditMbank.fromMap(json.decode(str));

String creditMbankToMap(CreditMbank data) => json.encode(data.toMap());

class CreditMbank {
    final String? productName;
    final String? takeDate;
    final int? amount;
    final int? percent;
    final int? loanMonths;
    final String? currency;
    final int? paymentDay;
    final List<String>? holidays;
    final List<String>? workDays;

    CreditMbank({
        this.productName,
        this.takeDate,
        this.amount,
        this.percent,
        this.loanMonths,
        this.currency,
        this.paymentDay,
        this.holidays,
        this.workDays,
    });

    CreditMbank copyWith({
        String? productName,
        String? takeDate,
        int? amount,
        int? percent,
        int? loanMonths,
        String? currency,
        int? paymentDay,
        List<String>? holidays,
        List<String>? workDays,
    }) => 
        CreditMbank(
            productName: productName ?? this.productName,
            takeDate: takeDate ?? this.takeDate,
            amount: amount ?? this.amount,
            percent: percent ?? this.percent,
            loanMonths: loanMonths ?? this.loanMonths,
            currency: currency ?? this.currency,
            paymentDay: paymentDay ?? this.paymentDay,
            holidays: holidays ?? this.holidays,
            workDays: workDays ?? this.workDays,
        );

    factory CreditMbank.fromMap(Map<String, dynamic> json) => CreditMbank(
        productName: json["product_name"],
        takeDate: json["take_date"],
        amount: json["amount"],
        percent: json["percent"],
        loanMonths: json["loanMonths"],
        currency: json["currency"],
        paymentDay: json["paymentDay"],
        holidays: json["holidays"] == null ? [] : List<String>.from(json["holidays"]!.map((x) => x)),
        workDays: json["workDays"] == null ? [] : List<String>.from(json["workDays"]!.map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "product_name": productName,
        "take_date": takeDate,
        "amount": amount,
        "percent": percent,
        "loanMonths": loanMonths,
        "currency": currency,
        "paymentDay": paymentDay,
        "holidays": holidays == null ? [] : List<dynamic>.from(holidays!.map((x) => x)),
        "workDays": workDays == null ? [] : List<dynamic>.from(workDays!.map((x) => x)),
    };
}
