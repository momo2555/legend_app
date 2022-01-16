import 'package:flutter/widgets.dart';
import 'package:legend_app/models/userModel.dart';

class UserProfileModel extends UserModel {
  String? userFirstName;
  String? userLastName;
  String? userProfileImage;
  String? userProfileImageURL;
  UserProfileModel(email, password, uid) : super(email, password, uid);
  UserProfileModel.byModel(UserModel user)
      : super(user.getEmail, '', user.getUid);
  set setUserFirstName(String? value) {
    userFirstName = value;
  }

  set setUserLastName(String? value) {
    userLastName = value;
  }

  set setUserProfileImage(String? value) {
    userProfileImage = value;
  }

  set setUserProfileImageURL(String? value) {
    userProfileImageURL = value;
  }

  get getUserFirstName {
    return userFirstName;
  }

  get getUserLastName {
    return userLastName;
  }

  get getUserProfileImage {
    return userProfileImage;
  }

  get getUserProfileImageURL {
    return userProfileImageURL;
  }
}
