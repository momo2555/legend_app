import 'package:flutter/material.dart';
import 'package:legend_app/server/profileServer.dart';
import 'package:legend_app/server/userConnection.dart';
import 'package:legend_app/server/userProfileModel.dart';
import 'package:legend_app/vues/profile/messages/messagesHome.dart';

class ProfileHome extends StatefulWidget {
  const ProfileHome({Key? key}) : super(key: key);

  @override
  _ProfileHomeState createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
  final double topHeight = 160;
  final double profileRadius = 70;
  UserProfileModel? userProfile;
  ProfileServer profileServer = ProfileServer();
  @override
  void initState() {
    // TODO: implement initState
    //ProfileServer profileServer = ProfileServer();
    //profileServer.test();
    super.initState();
    profileServer.getUserProfile.then((UserProfileModel user) {
      setState(() => userProfile = user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          _topProfile(context),
          Text(
            userProfile != null
                ? userProfile?.getUserFirstName +
                    ' ' +
                    userProfile?.getUserLastName
                : '',
            style:
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 24),
          ),
        ],
      ),
    );
  }

  Widget _topProfile(BuildContext context) {
    dynamic profileImg = userProfile?.getUserProfileImageURL != null
        ? NetworkImage(userProfile?.getUserProfileImageURL)
        : AssetImage("assets/background/loading.gif");

    return Padding(
      padding: EdgeInsets.only(bottom: profileRadius + 10),
      child: Stack(
        alignment: AlignmentDirectional.center,
        clipBehavior: Clip.none,
        children: [
          Container(
              color: Theme.of(context).primaryColor,
              child: SizedBox(
                height: topHeight,
                width: double.infinity,
              )),
          Positioned(
            top: topHeight - profileRadius - 8,
            child: ClipOval(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: SizedBox(
                  height: profileRadius * 2 + 16,
                  width: profileRadius * 2 + 16,
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 30,
            child: InkWell(
              onTap: () {
                //go to messages
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return MessagesHome();
                  },
                ));
              },
              child: Container(
                  height: 45,
                  width: 45,
                  //color: Colors.red,
                  child: Icon(
                    Icons.message,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    size: 35,
                  )),
            ),
          ),
          Positioned(
            top: 20,
            right: 30,
            child: InkWell(
              onTap: () {
                UserConnection userConnection = UserConnection();
                userConnection.logout();
              },
              child: Container(
                  height: 45,
                  width: 45,
                  //color: Colors.red,
                  child: Icon(
                    Icons.logout,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    size: 35,
                  )),
            ),
          ),
          Positioned(
            top: topHeight - profileRadius,
            child: CircleAvatar(
              backgroundImage: profileImg,
              radius: profileRadius,
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
          Positioned(
            top: topHeight + 20,
            left: MediaQuery.of(context).size.width / 2 + 40,
            child: InkWell(
              child: ClipOval(
                child: Container(
                  height: 35,
                  width: 35,
                  color: Theme.of(context).primaryColor,
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
