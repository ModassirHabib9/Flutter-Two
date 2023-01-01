import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_coin/common_widget/my_custom_button.dart';
import 'package:we_coin/utils/color_manager.dart';
import 'package:we_coin/view/auth/sign_up.dart';

import '../../common_widget/my_custom_textfield.dart';
import '../../data/repositry/identity_verification.dart';
import '../../utils/image_manager.dart';

import '../dashboard/drawer.dart';
import '../dashboard/navbar.dart';
import '../dashboard/navigation_pages/home_page/home_page.dart';

class AddressVerficationScreen extends StatefulWidget {
  const AddressVerficationScreen({Key? key}) : super(key: key);

  @override
  State<AddressVerficationScreen> createState() =>
      _AddressVerficationScreenState();
}

class _AddressVerficationScreenState extends State<AddressVerficationScreen> {
  String? name = '';
  void isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    name = sp.getString('string') ?? '';
    print(sp.getString('string'));
    print("=======> ${name}");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLogin();
  }

  File? selectedImage;
  // File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  Future chooseImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          selectedImage = selected;
        });
      } else {
        print("========= Error");
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          selectedImage = File("a");
        });
      } else {
        print("========= Please Select the image");
      }
    } else {
      print("Something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    final _address = Provider.of<IdentityVerification>(context, listen: false);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.28,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                  image: new AssetImage(ImageManager.splash_bar),
                  fit: BoxFit.fill,
                )),
                child: SvgPicture.asset(ImageManager.app_name),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text(
                        "Address Verfication",
                        style: TextStyle(
                            fontSize: 24.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: Text(
                        "Lorem Ipsum is simply dummy text of the\n printing and typesetting industry.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: ColorsManager.TEXT_COLOR),
                      ),
                    ),
                    SizedBox(height: 55.h),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: Text(
                        "Upload Address Proof",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ColorsManager.COLOR_BLACK, fontSize: 16.sp),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    DottedBorder(
                      color: ColorsManager.APP_MAIN_COLOR,
                      strokeWidth: 2,
                      dashPattern: [9, 6],
                      radius: Radius.circular(10),
                      borderType: BorderType.RRect,
                      child: InkWell(
                        onTap: () {
                          chooseImage();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 150,
                          height: 90,
                          decoration: BoxDecoration(
                              color: ColorsManager.COLOR_CONTAINER,
                              borderRadius: BorderRadius.circular(9)),
                          child: selectedImage == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      ImageManager.upload_pic,
                                      height: 40,
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(height: 10),
                                    Text("Upload File"),
                                  ],
                                )
                              : kIsWeb
                                  ? Image.memory(
                                      webImage,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.file(
                                      selectedImage!,
                                      fit: BoxFit.fill,
                                    ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyCustomButton(
                onPressedbtn:
                    () => /*_address.address_verification(
                    context, selectedImage.toString()),*/
                        Get.to(Dashboard()),
                text: "Submit",
                mergin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
