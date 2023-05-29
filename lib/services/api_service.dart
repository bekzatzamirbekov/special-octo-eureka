import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/credit_mbank.dart';
class ApiService {
  Future<CreditMbank> fetchCredits() async {
    print(" ==== test_task started ====");
    final response = await http.get(Uri.parse('https://identification.cbk.kg/api/test_task'));
    if (response.statusCode == 200) {
      final utf8Body = utf8.decode(response.bodyBytes); // Decode the response body using UTF-8
      final Map<String, dynamic> jsonResponse = jsonDecode(utf8Body);
      final CreditMbank credit = CreditMbank.fromMap(jsonResponse);
      // final CreditMbank credit = creditMbankFromMap("""{
      //     "product_name": "Кредит на бизнес",
      //     "take_date": "27.04.2023",
      //     "amount": 100000,
      //     "percent" : 18,
      //     "loanMonths" : 12,
      //     "currency": "USD",
      //     "paymentDay" : 13,
      //     "holidays": [
      //        "13.05.2023","14.05.2023","27.05.2023","12.06.2023","16.06.2023","03.06.2023","01.06.2023","08.07.2023","20.07.2023","12.07.2023","12.08.2023","16.08.2023","08.09.2023","16.09.2023","18.10.2023","26.10.2023","23.10.2023","26.11.2023","22.11.2023","16.11.2023","01.12.2023","22.12.2023","06.12.2023","12.12.2023","18.12.2023","16.01.2024","26.01.2024","08.01.2024","16.01.2024","26.01.2024","12.02.2024","22.02.2024","12.02.2024","13.02.2024","22.03.2024","06.03.2024","23.03.2024","18.03.2024"
      //     ],
      //     "workDays": [
      //          "20.05.2023","08.06.2023","08.07.2023","08.08.2023","01.09.2023","16.10.2023","08.11.2023","18.12.2023","06.01.2024","03.02.2024","26.03.2024"
      //     ]
      // }""");


      log("BODY: ");
      return credit;
    } else {
      print("error: ${response.statusCode} ${response.body}");
      throw Exception("Error on CRUD");
    }
  }
}
