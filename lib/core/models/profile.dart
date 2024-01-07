import 'dart:convert';

import 'package:infinite_escrow/core/constants.dart';

class ProfileModel {
  late int id;
  late String firstname;
  late String lastname;
  late String username;
  late String email;
  late String countryCode;
  late String mobile;
  late int? refBy;
  late String balance;
  late String? image;
  late int status;
  late int ev;
  late int? sv;
  late int? ts;
  late int? tv;
  late String? tsc;
  late String createdAt;
  late String updatedAt;
  late AddressModel address;
  ProfileModel({required this.balance, required this.email, required this.countryCode, required this.createdAt, required this.id, required this.updatedAt,
    required this.ev, required this.firstname, required this.image, required this.lastname, required this.mobile, required this.refBy, required this.status,
    required this.sv, required this.ts, required this.tsc,
    required this.tv, required this.username, required this.address
  });
  static ProfileModel fromJson(dynamic data) {
    return ProfileModel(balance: data['balance'] ?? '', email: data['email'], countryCode: data['country_code'],
        createdAt: data['created_at'],
        id: data['id'], updatedAt: data['updated_at'], ev: data['ev'] != null ? int.parse(data['ev'].toString()): 0, firstname: data['firstname'],
        image: data['image'] != null ? Constants.imageUrl+data['image']: null, lastname: data['lastname'], mobile: data['mobile'],
        refBy: data['ref_by'] != null ? int.parse(data['ref_by'].toString()): 0, status: data['status'] != null ? int.parse(data['status'].toString()): 0, sv: data['sv']!= null? int.parse(data['sv'].toString()): 0,
        ts:  data['ts'] != null? int.parse(data['ts'].toString()): 0, tsc: data['tsc'], tv: data['tv']!=null ? int.parse(data['tv'].toString()) : 0,
        username: data['username'], address: AddressModel.fromJson(data['address'])
    );
  }
}

class AddressModel {
  late String? address;
  late String? state;
  late String? zip;
  late String country;
  late String? city;
  AddressModel({required this.state, required this.city, required this.address, required this.country, required this.zip});
  static fromJson(dynamic data){
    return AddressModel(state: data['state'], city: data['city'], address: data['address'], country: data['country'], zip: data['zip']);
  }
}