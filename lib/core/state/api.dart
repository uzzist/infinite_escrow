import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/all_transaction_model.dart';

class AppApi extends ChangeNotifier {
  Future<ShowAllTransactions> getAllTransactions() async {
    try {
      var token = await getToken();
      print("token is ==> ${token}");
      var headers = {'Authorization': 'Bearer $token'};
      var request = http.MultipartRequest('GET',
          Uri.parse('https://www.infiniteescrow.com/api/m/transactions'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
        final tData = jsonDecode(await response.stream.bytesToString());
        return ShowAllTransactions.fromJson(tData);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
    throw Exception();
  }

  Future<String> getToken() async {
    final LocalStorage storage = LocalStorage('LocalStorage');
    await storage.ready;
    var value = storage.getItem('token') ?? '';
    return value;
  }
}
