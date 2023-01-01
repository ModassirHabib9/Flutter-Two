import 'dart:convert';
import 'dart:io';

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:we_coin/common_widget/my_custom_button.dart';
import 'package:we_coin/common_widget/my_custom_textfield.dart';
import 'package:we_coin/utils/color_manager.dart';
import 'package:http/http.dart' as http;
import 'package:we_coin/view/dashboard/navigation_pages/profile/pic_widget/select_photo_options_screen.dart';
import '../../../../data/model/view_profile_model.dart';
import '../../../../data/repositry/edit_profilr_repo.dart';
import '../../../../data/repositry/image_pick_provider.dart';
import '../../../../data/repositry/view_profile_get.dart';
import 'forgot_password.dart';

class EditProfilePageScreen extends StatefulWidget {
  EditProfilePageScreen(
      {Key? key,
      this.fullName,
      this.email,
      this.phone,
      this.country,
      this.state,
      this.city,
      this.picture})
      : super(key: key);
  static const id = 'set_photo_screen';

  String? fullName, email, phone, country, state, city, picture;

  @override
  State<EditProfilePageScreen> createState() => _EditProfilePageScreenState();
}

class _EditProfilePageScreenState extends State<EditProfilePageScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  String countryValue = '';
  void _loadData() async {
    // setting the initial value in the input controller
    fullNameController.text = widget.fullName.toString();
    emailController.text = widget.email.toString();
    phoneController.text = widget.phone.toString();
    countryController.text = widget.country.toString();
    stateController.text =
        widget.state == null ? "State" : widget.state.toString();
    cityController.text = widget.city == null ? "City" : widget.city.toString();
    countryValue = widget.country.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
    print("Email${widget.phone!}");
  }
  File? _image;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
    await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }
  // api response data model class to store the data in it and use it in the app to show it in the ui
  ViewProfileModel? viewProfileModel;

  @override
  Widget build(BuildContext context) {
    final _sign_up = Provider.of<EditProfile_Provider>(context);
    final viewPro = Provider.of<ViewProfile_Provider>(context, listen: false);
    final pickImage =
        Provider.of<ProfileImageController>(context, listen: false);
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => ProfileImageController(),
        child: Consumer<ProfileImageController>(
          builder: (context, provider, child) {
            return Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      // background image and bottom contents
                      Container(
                        color: ColorsManager.WHITE_COLOR,
                        child: Column(
                          children: <Widget>[
                            Container(
                                height: 160.0,
                                color: ColorsManager.APP_MAIN_COLOR,
                                child: Center(
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  Icons.arrow_back_ios,
                                                  color:
                                                      ColorsManager.WHITE_COLOR,
                                                ),
                                                onPressed: () => Get.back(),
                                              ),
                                              Text(
                                                'Edit Profile',
                                                style: TextStyle(
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: ColorsManager
                                                        .WHITE_COLOR),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.to(
                                                      ForgotPasswordPageScreen());
                                                },
                                                child: CircleAvatar(
                                                    child: Icon(
                                                        Icons.lock_person,
                                                        color: ColorsManager
                                                            .WHITE_COLOR)),
                                              )
                                            ])))),
                            SizedBox(height: 50),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: ListView(
                                  primary: false,
                                  children: [
                                    MyCustomTextField(
                                      // show full name from api in text field and edit it if you want
                                      controller: fullNameController,
                                      hint: "Full Name",
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                    SizedBox(height: 10.h),
                                    MyCustomTextField(
                                      controller: phoneController,
                                      hint: "Phone Number",
                                      prefixIcon: Icon(Icons.phone),
                                    ),
                                    SizedBox(height: 10.h),
                                    MyCustomTextField(
                                      controller: emailController,
                                      hint: "Email",
                                      prefixIcon: Icon(Icons.email_outlined),
                                    ),
                                    SizedBox(height: 10.h),
                                    MyCustomTextField(
                                      controller: countryController,
                                      hint: "Address",
                                      // prefixIcon: Icon(Icons.location_on_outlined),
                                    ),
                                    SizedBox(height: 10.h),
                                    Container(
                                      child: CSCPicker(
                                        showStates: false,
                                        showCities: false,
                                        flagState: CountryFlag.ENABLE,
                                        defaultCountry: DefaultCountry.Pakistan,

                                        ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                                        dropdownDecoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: const Color(0xFFF0F0F0),
                                            border: Border.all(
                                                color: const Color(0xFFF0F0F0),
                                                width: 4.5)),

                                        ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                                        disabledDropdownDecoration:
                                            BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: const Color(0xFFF0F0F0),
                                                border: Border.all(
                                                    color:
                                                        const Color(0xFFF0F0F0),
                                                    width: 4.5)),

                                        ///placeholders for dropdown search field
                                        countrySearchPlaceholder:
                                            "$countryValue",
                                        // get country name from api
                                        // defaultCountry: DefaultCountry.Pakistan == countryValue ? "": ,

                                        ///labels for dropdown
                                        countryDropdownLabel: "$countryValue",
                                        selectedItemStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),

                                        ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                                        dropdownHeadingStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),

                                        ///DropdownDialog Item style [OPTIONAL PARAMETER]
                                        dropdownItemStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                        dropdownDialogRadius: 10.0,
                                        searchBarRadius: 10.0,

                                        onCountryChanged: (value) {
                                          setState(() {
                                            ///store value in country variable
                                            // get country name from api
                                            countryValue = value;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: MyCustomTextField(
                                          hint: "State",
                                          controller: stateController,
                                          prefixIcon: Icon(Icons.map_outlined),
                                          suffixIcon:
                                              Icon(Icons.expand_more_outlined),
                                        )),
                                        SizedBox(width: 10.w),
                                        Expanded(
                                            child: MyCustomTextField(
                                          hint: "City",
                                          controller: cityController,
                                          prefixIcon:
                                              Icon(Icons.apartment_outlined),
                                          suffixIcon:
                                              Icon(Icons.expand_more_outlined),
                                        )),
                                      ],
                                    ),
                                    MyCustomButton(
                                      child: _sign_up.loading
                                          ? CircularProgressIndicator(
                                              color: ColorsManager.WHITE_COLOR,
                                            )
                                          : Text(
                                              "Confirm",
                                              style: TextStyle(
                                                  color: ColorsManager
                                                      .WHITE_COLOR),
                                            ),
                                      mergin:
                                          EdgeInsets.symmetric(vertical: 20.h),
                                      onPressedbtn: () {
                                        print("Image${_image}");
                                        _sign_up.editeProfile(
                                            context,
                                            fullNameController.text,
                                            emailController.text,
                                            phoneController.text,
                                            // phoneController.text,
                                            countryValue.toString(),
                                            stateController.toString(),
                                            cityController.toString(),
                                            // provider.image.toString()
                                            _image!.path
                                        );
                                        _picUpdate(_image!.path);
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Profile image section

                      Positioned(
                        top:
                            110.0,

                        child: Center(
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              _showSelectPhotoOptions(context);
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: 110.0,
                                  width: 110.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Center(
                                    child: _image == null
                                        ?  CircleAvatar(
                                          backgroundImage: NetworkImage(widget.picture.toString()),
                                          radius: 200.0,
                                          )
                                        : CircleAvatar(
                                      backgroundImage: FileImage(_image!),
                                      radius: 200.0,
                                    ),
                                  )),Positioned(right: 0,bottom: 0,child: CircleAvatar(radius: 16,backgroundColor: ColorsManager.YELLOWBUTTON_COLOR,child: IconButton(onPressed: () => _showSelectPhotoOptions(context),icon:Icon(Icons.edit,color: ColorsManager.WHITE_COLOR,
                                size: 18,),)))],

                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

}
void _picUpdate(String image) async{
  var headers = {
    'authentication': '1___31aeaac265e2d74ea095fa3bb524f7fea905f586b10fb4b3c4ff445fea9babb31eff777b14336864'
  };
  var request = http.MultipartRequest('POST', Uri.parse('http://wecoin.pk/weCoinApp/api/enrollment/editProfile'));

  request.files.add(http.MultipartFile.fromBytes('image', await File.fromUri(Uri.file(image)).readAsBytes()));
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }
}