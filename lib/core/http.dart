import 'dart:convert';

import 'package:infinite_escrow/core/models/escrow_category.dart';
import 'package:infinite_escrow/core/models/profile.dart';
import 'package:localstorage/localstorage.dart';
import 'package:infinite_escrow/core/constants.dart';
import 'package:http/http.dart' as http;

class HttpRequest extends BaseHttpRequest {

  Future<ResponseBody> registor(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/m/register');
    var token = await getToken();
    var request = http.MultipartRequest('POST', url);
    Map<String, String> header = {"Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);
    request.fields.addAll(body);
    var res = await request.send();
    return await parseResponseFormRegister(res, false);
  }
  Future<ResponseBody> login(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/m/login');
    var token = await getToken();
    var request = http.MultipartRequest('POST', url);
    Map<String, String> header = {"Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);
    request.fields.addAll(body);
    var res = await request.send();
    return await parseResponseFormRegister(res, true);
  }
  Future<ResponseBody> message(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/m/escrow/message/send');
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll(body);
    if( body['file'] != null){
      request.files.add( await http.MultipartFile.fromPath('file', body['file']!));
    }
    var token = await getToken();
    Map<String, String> header = {"Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);
    var res = await request.send();
    return await parseResponseFormRegister(res, false);
  }

  Future<ResponseBody> ticketMessage(dynamic body,int id) async {
    var url = Uri.https(Constants.baseUrl, 'api/m/ticket/reply/${id.toString()}');
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll(body);
    if( body['attachments'] != null){
      request.files.add( await http.MultipartFile.fromPath('attachments', body['attachments']!));
    }
    var token = await getToken();
    Map<String, String> header = {"Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);
    var res = await request.send();
    return await parseResponseFormRegister(res, false);
  }
  Future<ResponseBody> forgetPassword(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/m/password/email');
    return baseFormRequest(url, body);
  }
  Future<ResponseBody> newEscrow(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/m/escrow/new');
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll(body);
    if( body['file'] != null){
      request.files.add( await http.MultipartFile.fromPath('file', body['file']!));
    }
    var token = await getToken();
    Map<String, String> header = {"Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);
    var res = await request.send();
    return await parseResponseFormRegister(res, false);
  }
  Future<ResponseBody> newTicket(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/m/ticket/new');
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll(body);
    if( body['attachments'] != null){
      request.files.add( await http.MultipartFile.fromPath('attachments', body['attachments']!));
    }
    var token = await getToken();
    Map<String, String> header = {"Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);
    var res = await request.send();
    return await parseResponseFormRegister(res, false);
  }
  Future<ResponseBody> verifyOtp(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/m/password/verify-code');
    return baseFormRequest(url, body);
  }
  Future<ResponseBody> withdrawPayment(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/m/submit-withdraw/payment');
    return baseFormRequest(url, body);
  }
  Future<ResponseBody> submitMilestone(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/m/submit-milestone');
    return baseFormRequest(url, body);
  }
  Future<ResponseBody> payMilestone(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/m/pay-milestone');
    return baseFormRequest(url, body);
  }
  Future<ResponseBody> fsEnable(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/m/2fa/enable');
    return baseFormRequest(url, body);
  }
  Future<ResponseBody> fsDisable(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/m/2fa/disable');
    return baseFormRequest(url, body);
  }
  Future<ResponseBody> submitDeposit(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/m/submit-deposit');
    return baseFormRequest(url, body);
  }
  Future<ResponseBody> stripePayment(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/n/stripe');
    return baseFormRequest(url, body);
  }
  Future<ResponseBody> submitWithdraw(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/m/submit-withdraw');
    return baseFormRequest(url, body);
  }
  Future<ResponseBody> signUpVerification(dynamic body) async {
    print(body.toString());
    var url = Uri.https(Constants.baseUrl, 'api/m/signup-verification');
    return baseFormRequest(url, body);
  }
  Future<ResponseBody> sendVerification(String email, String type) async {
    var url = Uri.https(Constants.baseUrl, 'api/m/send-verification');
    print({'type': type, 'email': email}.toString());
    return baseFormRequest(url, {'type': type, 'email': email});
  }
  Future<ResponseBody> updateProfile(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/m/update-profile');
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll(body);
    if( body['file'] != null){
      request.files.add( await http.MultipartFile.fromPath('file', body['file']!));
    }
    var token = await getToken();
    Map<String, String> header = {"Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);
    var res = await request.send();
    return await parseResponseFormRegister(res, false);
  }
  Future<ResponseBody> updatePassword(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/m/change-password');
    return baseFormRequest(url, body);
  }
  Future<ResponseBody> resetPassword(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/m/password/reset');
    return baseFormRequest(url, body);
  }
  Future<ResponseBody> getStates() async {
    return get('api/m/states', {"": ""});
  }
  Future<ResponseBody> getBlogs() async {
    return get('api/m/blogs', {"": ""});
  }
  Future<ResponseBody> getFaShow() async {
    return get('api/m/2fa/show', {"": ""});
  }
  Future<ResponseBody> getBalance() async {
    return get('api/m/states/balance', {"": ""});
  }
  Future<ResponseBody> getDepositList() async {
    return get('api/m/deposit/list', {"": ""});
  }
  Future<ResponseBody> getDepositMethordList(int type) async {
    return get(type==1? 'api/m/submit-deposit/methods': 'api/m/submit-withdraw/methods', {"": ""});
  }
  Future<ResponseBody> getDepositPendingList() async {
    return get('api/m/deposit/pending', {"": ""});
  }
  Future<ResponseBody> getWithdrawList() async {
    return get('api/m/withdraw/list', {"": ""});
  }
  Future<ResponseBody> getEscrowCategoryList() async {
    return get('api/m/escrow-category', {"": ""});
  }
  Future<ResponseBody> getWithdrawPendingList() async {
    return get('api/m/withdraw/pending', {"": ""});
  }
  Future<ResponseBody> getMilestoneList() async {
      return get('api/m/milestone/list', {"": ""});
  }
  Future<ResponseBody> getMilestonesList(int id) async {
    return get('api/m/list-milestones', {"id": id.toString()});
  }
  Future<ResponseBody> getMilestonePendingList() async {
    return get('api/m/milestone/pending', {"": ""});
  }
  Future<ResponseBody> getTickets({bool only = false}) async {
    if(only){
      return get('api/m/ticket/list', {"type": "1"});
    }
    return get('api/m/ticket/list', {"": ""});
  }
  Future<ResponseBody> getTicketById(int id) async {
    return get('api/m/ticket/view/'+id.toString() , {"": ""});
  }
  Future<ResponseBody> getEscrowList() async {
    return get('api/m/escrow-list', {"": ""});
  }
  Future<ResponseBody> getEscrowAcceptedList() async {
    return get('api/m/escrow-list/accepted', {"": ""});
  }
  Future<ResponseBody> getEscrowNotAcceptedList() async {
    return get('api/m/escrow-list/not-accepted', {"": ""});
  }
  Future<ResponseBody> getEscrowCompletedList() async {
    return get('api/m/escrow-list/completed', {"": ""});
  }
  Future<ResponseBody> getEscrowCanceledList() async {
    return get('api/m/escrow-list/canceled', {"": ""});
  }
  Future<ResponseBody> getEscrowDisputedList() async {
    return get('api/m/escrow-list/disputed', {"": ""});
  }
  Future<ResponseBody> getEscrowDetail(int id) async {
    return get('api/m/escrow/'+id.toString(), {"": ""});
  }
  // Future<ResponseBody> cancelEscrow(int id) async {
  //   return get('api/m/escrow/cancel', {"escrow_id": id.toString()});
  // }

  Future<ResponseBody> cancelEscrow(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/m/escrow/cancel');
    return baseFormRequest(url, body);
  }

  // Future<ResponseBody> acceptEscrow(int id) async {
  //   return get('api/m/escrow/accept', {"escrow_id": id.toString()});
  // }

  Future<ResponseBody> acceptEscrow(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/m/escrow/accept');
    return baseFormRequest(url, body);
  }

  Future<ResponseBody> disputeEscrow(int id, String message) async {
    return get('api/m/escrow/dispute', {"escrow_id": id.toString(), 'details': message});
  }

  Future<ResponseBody> currencyExchange(String currency) async {
    return get('api/m/currencyExchange', {"currency": Constants.currencyType[currency]});
  }

}

class ResponseBody {
  bool success;
  dynamic data;
  String message;
  ResponseBody({required this.success, this.data, required this.message});
}

class BaseHttpRequest {
  Future<ResponseBody> baseFormRequest(Uri url, dynamic body) async {
    var token = await getToken();
    var request = http.MultipartRequest('POST', url);
    Map<String, String> header = {"Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);
    request.fields.addAll(body);
    var res = await request.send();
    return await parseResponseFormRegister(res, false);
  }
  Future<ResponseBody> post(
      String urlPath, dynamic body, dynamic qp, bool saveT) async {
    var url = Uri.https(Constants.baseUrl, urlPath, qp);
    var token = await getToken();
    var newBody = body;
    if (body != null) {
      newBody = jsonEncode(body);
    }
    var response = await http.post(url, body: newBody, headers: {
      "Authorization": 'Bearer ${token ?? ''}',
      'Accept': 'application/json'
    });
    return parseResponse(response, saveT);
  }

  Future<ResponseBody> get(String urlPath, dynamic qp) async {
    var url = Uri.https(Constants.baseUrl, urlPath, qp);
    var token = await getToken();
    var response = await http
        .get(url, headers: {"Authorization": 'Bearer ${token ?? ''}'});
    return parseResponse(response, false);
  }

  Future<ResponseBody> postWithOutQp(
      String urlPath, dynamic body, bool saveT) async {
      var url = Uri.https(Constants.baseUrl, urlPath);
      var token = await getToken();
      var newBody = body;
      if (body != null) {
        newBody = jsonEncode(body);
      }
      var response = await http.post(url,
          body: newBody, headers: {"Authorization": 'Bearer ${token ?? ''}'});
      return parseResponse(response, saveT);
  }

  Future<ResponseBody> parseResponse(dynamic response, bool saveT) async {
    var responseBody = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    if (response.statusCode == 401) {
      clearToken();
      var message = getMessage(responseBody);
      return ResponseBody(success: false, message: message);
    } else if (response.statusCode == 400 ||
        response.statusCode == 422 ||
        response.statusCode == 403 ||
        response.statusCode == 409 ||
        response.statusCode == 500) {
      var message = getMessage(responseBody);
      return ResponseBody(success: false, message: message);
    } else {
      if (saveT) {
        await saveToken(responseBody['data']['access_token']);
        await saveUser(responseBody['data']['user']);
      }
      return ResponseBody(success: true, message: '', data: responseBody);
    }
  }

  Future<ResponseBody> parseResponseFormRegister(
      dynamic response, bool saveAuthToken) async {
    var result = await response.stream.bytesToString();
    print(result.toString());
    var responseBody = jsonDecode(result) as Map;
    print(response.statusCode);
    if (response.statusCode == 401) {
      clearToken();
      var message = getMessage(responseBody);
      return ResponseBody(success: false, data: responseBody['data'], message: message);
    } else if (response.statusCode == 400 ||
        response.statusCode == 422 ||
        response.statusCode == 403 ||
        response.statusCode == 409 ||
        response.statusCode == 500) {
      var message = getMessage(responseBody);
      return ResponseBody(success: false,  data: responseBody['data'], message: message);
    } else {
      if (saveAuthToken) {
        await saveToken(responseBody['data']['access_token']);
        await saveUser(responseBody['data']['user']);
      }
      return ResponseBody(success: true, message: '', data: responseBody);
    }
  }
  String getMessage(responseBody){
    if(responseBody['message'] == null){
      return 'Server Error';
    }
    if(responseBody['message'].length > 0){
      return responseBody["message"][0];
    }
    return responseBody["message"];
  }

  Future<ResponseBody> parseResponseForm(dynamic response) async {
    var result = await response.stream.bytesToString();
    var responseBody = jsonDecode(result != "" ? result : '{}') as Map;
    if (response.statusCode == 401) {
      clearToken();
      var message = getMessage(responseBody);
      return ResponseBody(success: false, message: message);
    } else if (response.statusCode == 400 ||
        response.statusCode == 422 ||
        response.statusCode == 403 ||
        response.statusCode == 500) {
      var message = getMessage(responseBody);
      return ResponseBody(success: false, message: message);
    } else {
      return ResponseBody(success: true, message: '', data: responseBody);
    }
  }

  Future<String> getToken() async {
    final LocalStorage storage = LocalStorage('LocalStorage');
    await storage.ready;
    var value = storage.getItem('token') ?? '';
    return value;
  }

  saveToken(token) async {
    final LocalStorage storage = LocalStorage('LocalStorage');
    await storage.ready;
    storage.setItem('token', token);
  }

  clearToken() async {
    final LocalStorage storage = LocalStorage('LocalStorage');
    await storage.ready;
    storage.clear();
  }

  checkToken() async {
    final LocalStorage storage = LocalStorage('LocalStorage');
    await storage.ready;
    return storage.getItem('token');
  }
  setOnBoard() async {
    final LocalStorage storage = LocalStorage('LocalStorage');
    await storage.ready;
    storage.setItem('onBoard', true);
  }
  getOnBoard() async {
    final LocalStorage storage = LocalStorage('LocalStorage');
    await storage.ready;
    return storage.getItem('onBoard');
  }
  saveUser(dynamic user) async {
    final LocalStorage storage = LocalStorage('LocalStorage');
    await storage.ready;
    storage.setItem('user', jsonEncode(user));
  }
  saveEscrowCatagory(dynamic user) async {
    final LocalStorage storage = LocalStorage('LocalStorage');
    await storage.ready;
    storage.setItem('escrowc', jsonEncode(user));
  }
  List<EscrowCategoryModel> getEscrowCatagory() {
    final LocalStorage storage = LocalStorage('LocalStorage');
    var us = storage.getItem('escrowc');
    var data = jsonDecode(us ?? '[]');
    return EscrowCategoryModel.fromJsonList(data);
  }
  Future<ProfileModel> getUser() async {
    final LocalStorage storage = LocalStorage('LocalStorage');
    await storage.ready;
    var us = storage.getItem('user');
    var data = jsonDecode(us ?? '{}');
    return ProfileModel.fromJson(data);
  }
  ProfileModel getUserSync() {
    final LocalStorage storage = LocalStorage('LocalStorage');
    var us = storage.getItem('user');
    var data = jsonDecode(us ?? '{}');
    return ProfileModel.fromJson(data);
  }
  saveCurrency(String token) async {
    final LocalStorage storage = LocalStorage('LocalStorage');
    await storage.ready;
    storage.setItem('currency', token);
  }
  String? getCurrency() {
    final LocalStorage storage = LocalStorage('LocalStorage');
    var us = storage.getItem('currency');
    return us;
  }
}
