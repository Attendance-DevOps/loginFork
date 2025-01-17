import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/controllers/controllers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/homePageAppBar.dart';
import 'package:flutter_auth/Screens/home/sideBarMenu.dart';
import 'package:flutter_auth/Screens/profile/tabs/personalInfo.dart';
import 'package:flutter_auth/controllers/visibilityController.dart';
import 'package:flutter_auth/Screens/profile/tabs/yourOrders.dart';
import 'package:flutter_auth/Screens/profile/tabs/yourProducts.dart';
import 'package:flutter_auth/Screens/utils/btnDesigns.dart';
import 'package:flutter_auth/Screens/utils/textDesigns.dart';
import 'package:flutter_auth/models/userModel.dart';
import 'package:get/get.dart';
import 'profileutils/profileComponents.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  String userid;
  ProfileScreen({Key? key, required this.userid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  /// Variables
  VisibilityController visibilityController = Get.put(VisibilityController());
  Controller controller = Get.put(Controller());
  List<Widget> pages = [
    PersonalInfo(),
    const YourOrders(),
    const YourProducts()
  ];
  late DatabaseReference _userRef;
  @override
  void initState() {
    super.initState();

    /// fetching user data corresponding to the user currently logged in
    _userRef =
        FirebaseDatabase.instance.ref().child("users").child(widget.userid);
    _userRef.onValue.listen((event) {
      Object? data = event.snapshot.value;
      Map<String, dynamic> dataMap = data as Map<String, dynamic>;
      controller.setUserModel(UserModel(
          firstName: dataMap['firstName'],
          lastName: dataMap['lastName'],
          email: dataMap['email'],
          instituteType: dataMap['instituteType'],
          instituteName: dataMap['instituteName'],
          instituteLocation: dataMap['instituteLocation']));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 247, 248, 1),
      endDrawer: SideBarMenu(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomePageAppBar(),
            Padding(
              padding: const EdgeInsets.fromLTRB(230, 20, 230, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("buyBuddy Account",
                              style: GoogleFonts.getFont(
                                "Nunito",
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: 35,
                                width: 100,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: CustomElevatedBtnStyle(),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Icon(Icons.edit),
                                      Text("Edit",
                                          style: GoogleFonts.getFont("Nunito"))
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                height: 35,
                                width: 100,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: ((context) {
                                      return const SignUpScreen();
                                    })));
                                  },
                                  style: CustomElevatedBtnStyle(),
                                  child: Text("Sign Out",
                                      style: GoogleFonts.getFont("Nunito")),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                                backgroundColor:
                                    Color.fromRGBO(231, 233, 237, 1),
                                radius: 50,
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.white,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(
                              () {
                                return CustomText(
                                  text:
                                      "${controller.userModel.value.firstName} ${controller.userModel.value.lastName}",
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(() {
                              return CustomText(
                                text: controller.userModel.value.email,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                textColor:
                                    const Color.fromARGB(255, 167, 161, 161),
                              );
                            }),
                            const SizedBox(
                              height: 30,
                            ),
                            ProfileInfo()
                          ],
                        )),
                    const SizedBox(
                      width: 45,
                    ),
                    Obx(() {
                      return Expanded(
                          flex: 3,
                          child: SingleChildScrollView(
                            child: pages[
                                visibilityController.visibilityIndex.value],
                          ));
                    })
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
