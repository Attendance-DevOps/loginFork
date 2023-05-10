import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/homePageAppBar.dart';
import 'package:flutter_auth/Screens/profile/personalInfo.dart';
import 'package:flutter_auth/Screens/profile/visibilityController.dart';
import 'package:flutter_auth/Screens/profile/yourOrders.dart';
import 'package:flutter_auth/Screens/profile/yourProducts.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  VisibilityController visibilityController=Get.put(VisibilityController());
  List<Widget> pages=[PersonalInfo(),YourOrders(),YourProducts()];
  @override
  Widget build(BuildContext context) {
    print("profile screen build");
    return Scaffold(
      appBar: HomePageAppBar(scaffoldKey: _scaffoldKey),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(100,20,100,0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "buyBuddy Account",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style:CustomElevatedBtnStyle(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [Icon(Icons.edit), Text("Edit")],
                      ),
                    ),
                    const SizedBox(width: 10,),
                    ElevatedButton(onPressed: () {}, child: const Text("Sign Out"),style: CustomElevatedBtnStyle(),)
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30,),
            Row(children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 212, 212, 212),
                      radius: 60,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      )),
                  const SizedBox(height: 10,),

                  CustomText(
                    text: "Honey Bansal",
                  ),
                  const SizedBox(height: 10,),
                  CustomText(
                    text: "honeybansal2968@gmail.com",
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    textColor: const Color.fromARGB(255, 167, 161, 161),
                  ),
                  const SizedBox(height: 30,),

                  CustomTextBtn(text: "Personal Information",fontSize: 20,onPressed: (){
                    visibilityController.setVisibility(0);
                  },),
                  CustomTextBtn(text: "Your Orders",fontSize: 20,onPressed: (){
                    visibilityController.setVisibility(1);
                  },),
                  CustomTextBtn(text: "Your Products",fontSize: 20,onPressed: (){
                    visibilityController.setVisibility(2);
                  },),
                ],
              )),
              Obx(() {
                return Expanded(child: pages[visibilityController.visibilityIndex.value]);
              })
            ]),
          ],
        ),
      ),
    );
  }
}

ButtonStyle CustomElevatedBtnStyle() {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.hovered)) {
            return const Color.fromARGB(
                255, 71, 117, 241); // set the hover color here
          }
          if (states.contains(MaterialState.pressed)) {
            return const Color(0xff0043fb); // set the hover color here
          }
          return const Color(0xff0043fb);
        }),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))));
  }

class CustomText extends StatelessWidget {
  String text;
  double? fontSize;
  FontWeight? fontWeight;
  Color? textColor;
  CustomText({Key? key,required this.text,this.fontSize,this.fontWeight,this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: fontSize??24,color: textColor??Colors.black,fontWeight: fontWeight??FontWeight.bold),);
  }
}

class CustomTextBtn extends StatelessWidget {
  String text;
  double? fontSize;
  FontWeight? fontWeight;
  Color? textColor;
  Function()? onPressed;
  CustomTextBtn(
      {Key? key,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.textColor,this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.hovered)) {
                return const Color(0xff0043fb); // set the hover color here
              }
              if (states.contains(MaterialState.pressed)) {
                return const Color(0xff0043fb); // set the hover color here
              }
              return textColor ?? const Color.fromARGB(255, 161, 164, 166);
            }),
            overlayColor: MaterialStateProperty.all(Colors.transparent)),
        child: Text(
          text,
          style: TextStyle(
              fontSize: fontSize ?? 24,
              fontWeight: fontWeight ?? FontWeight.bold),
        ));
  }
}
