import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:legend_app/models/userModel.dart';
import 'package:legend_app/server/userConnection.dart';
import 'package:legend_app/server/userProfileModel.dart';

class ProfileServer {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  UserConnection userConnection = UserConnection();
  FirebaseStorage fireStorage = FirebaseStorage.instance;

  Future<UserProfileModel> get getUserProfile async {
    UserModel user = await userConnection.UserConnected;
    UserProfileModel userProfile = UserProfileModel.byModel(user);
    DocumentReference profileDataRef =
        fireStore.collection('users').doc(userProfile.getUid);
    DocumentSnapshot profileData = (await profileDataRef.get());
    userProfile.setUserFirstName = profileData.get('userFirstName');
    userProfile.setUserLastName = profileData.get('userLastName');
    userProfile.setUserProfileImage = profileData.get('userProfileImage');
    //get the link of the profile image
    Reference imgRef = fireStorage.ref(userProfile.getUserProfileImage);
    userProfile.setUserProfileImageURL = await imgRef.getDownloadURL();

    return userProfile;
  }
}
