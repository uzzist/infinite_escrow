import 'package:flutter/foundation.dart';
import 'package:infinite_escrow/core/models/profile.dart';

class BaseState with ChangeNotifier{
  ProfileModel? profile;

  updateProfile(ProfileModel p){
    profile = p;
    notifyListeners();
  }
}