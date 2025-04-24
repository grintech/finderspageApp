import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projects/controllers/postProfileController.dart';
import 'package:projects/data/models/userModel.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/commonWidgets/CommonAppBar.dart';
import 'package:projects/utils/commonWidgets/commonButton.dart';
import 'package:projects/utils/commonWidgets/commonTextField.dart';
import 'package:projects/utils/helper/dateHelper.dart';
import 'package:projects/utils/imageViewer.dart';
import 'package:projects/utils/routes.dart';

import '../../data/apiConstants.dart';
import '../../utils/util.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  PostProfileController controller = Get.put(PostProfileController());






  var selectedDOB = DateTime.now().obs;

  var addLinks = true.obs;
  var saveLinks = true.obs;
  var editLinks = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        leading: true,
        centreTxt: true,
        title: "Edit Profile",
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusScopeNode());
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Stack(
                    children: [
                      Obx(() {
                        final coverImagePath = controller.coverImagePath.value;
                        final coverImg = controller.userModel.value?.user?.cover_img;

                        Widget imageWidget;

                        if (coverImagePath.isNotEmpty && File(coverImagePath).existsSync()) {
                          // Local file exists
                          imageWidget = Image.file(
                            File(coverImagePath),
                            width: Get.width,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Image.asset("assets/images/no_image.png", fit: BoxFit.contain),
                          );
                        } else if (coverImg != null && coverImg.isNotEmpty) {
                          // Load from network
                          imageWidget = Image.network(
                            "${ApiConstants.profileUrl}/$coverImg",
                            width: Get.width,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Image.asset("assets/images/no_image.png", fit: BoxFit.contain),
                          );
                        } else {
                          // Fallback image
                          imageWidget = Image.asset(
                            "assets/images/no_image.png",
                            width: Get.width,
                            height: 200,
                            fit: BoxFit.contain,
                          );
                        }

                        return Container(
                          margin: const EdgeInsets.only(bottom: 40),
                          height: 200,
                          width: Get.width,
                          child: imageWidget,
                        );
                      }),

                      Positioned(
                        right: 12, bottom: 50,
                        child: GestureDetector(
                          onTap: () {
                            controller.selectCoverImage();
                          },
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFFDC7228), Color(0xFFA54DB7)],
                              ),
                            ),
                            child: Image.asset(
                              "assets/images/edit-icon.png",
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    left: 20,
                    child: GestureDetector(
                      onTap: () {
                        controller.selectProfileImage();
                        // Get.toNamed(Routes.editProfileRoute);
                      },
                      child: Stack(
                        children: [
                          Obx(() {
                            final profileImagePath = controller.profileImagePath.value;
                            final userImage = controller.userModel.value?.user?.image;

                            Widget imageWidget;

                            if (profileImagePath.isNotEmpty && File(profileImagePath).existsSync()) {
                              // Use local file if it exists
                              imageWidget = ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  File(profileImagePath),
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>ImageView(height: 80, width: 80,),
                                ),
                              );
                            } else if (userImage != null && userImage.isNotEmpty) {
                              // Load from network if URL is valid
                              imageWidget = ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  "${ApiConstants.profileUrl}/$userImage",
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => ImageView(height: 80, width: 80,),
                                ),
                              );
                            } else {
                              // Fallback
                              imageWidget = ImageView(height: 80, width: 80,);
                            }

                            return Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: imageWidget,
                            );
                          }),
                          Positioned(
                            bottom: 2,
                            right: 0,
                            child: Container(
                              width: 20,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Color(0xFFDC7228), Color(0xFFA54DB7)],
                                ),
                              ),
                              child: Image.asset(
                                "assets/images/edit-icon.png",
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              // Form Fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: CommonTextField(
                            hint: "Enter First Name",
                            margin: EdgeInsets.only(top: 20, bottom: 10),
                            textController: controller.nameController,
                            keyboardType: TextInputType.text,
                            keyboardAction: TextInputAction.next,
                          ),
                        ),
                        SizedBox(width: 12,),
                        Flexible(
                          child: CommonTextField(
                            hint: "Enter Username",
                            margin: EdgeInsets.only(top: 20, bottom: 10),
                            textController: controller.usernameController,
                            keyboardType: TextInputType.text,
                            keyboardAction: TextInputAction.next,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: CommonTextField(
                            hint: "Enter Email ID",
                            read: true,
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            textController: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            keyboardAction: TextInputAction.next,
                          ),
                        ),
                        SizedBox(width: 12,),
                        Flexible(
                          child: CommonTextField(
                            hint: "Enter Phone Number",
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            textController: controller.phoneController,
                            keyboardType: TextInputType.phone,
                            keyboardAction: TextInputAction.next,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Flexible(
                          child: CommonTextField(
                            hint: "Enter Zip Code",
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            textController: controller.zipController,
                            keyboardType: TextInputType.number,
                            keyboardAction: TextInputAction.next,
                          ),
                        ),
                        SizedBox(width: 12,),
                        Obx(()=>GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime(2007),
                              firstDate: DateTime(2007),
                              lastDate: DateTime(2040),
                            );

                            if (pickedDate != null) {
                              selectedDOB.value = pickedDate;
                              print("Selected date: $pickedDate"); // Handle the selected date
                            }
                          },
                          child: Container(
                            height: 48,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: 1.5, color: fieldBorderColor)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MyTextWidget(data:DateFormat('dd-MMMM-yy').format(selectedDOB.value)),
                                SizedBox(width: 12,),
                                Image.asset("assets/images/calendar-icon.png", scale:4,)
                              ],
                            ),
                          ),
                        ))
                      ],
                    ),
                    CommonTextField(
                      hint: "Enter Bio",
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      textController: controller.bioController,
                      keyboardType: TextInputType.phone,
                      keyboardAction: TextInputAction.next,
                      lines: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyTextWidget(data: "Add Your Links", size: 16, weight: FontWeight.w600,),
                        // SizedBox(width: 20,),
                        Spacer(),
                        GestureDetector(
                            onTap: () {
                              addLinks.value = !addLinks.value;
                            },
                            child: Icon(Icons.add_circle_outline_outlined, color: fieldBorderColor, size: 25,))

                      ],
                    ),
                    Obx(()=>
                        Visibility(
                          visible: !addLinks.value,
                          child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: CommonTextField(
                                  hint: "Title",
                                ),
                              ),
                              SizedBox(width: 20,),
                              Flexible(
                                child: CommonTextField(
                                  hint: "Url",
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  addLinks.value = true;
                                  saveLinks.value = false;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Icon(Icons.check_circle_outline, size: 25,
                                    color: fieldBorderColor,),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),)),
                    Obx(()=>
                        Visibility(
                          visible: !saveLinks.value,
                            child: editLinks.value
                                ?Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyTextWidget(data: "FindersPage", size: 14, weight: FontWeight.w500,),
                            MyTextWidget(data: "https://www.finderspage.com", size: 12, weight: FontWeight.w400,),
                          ],
                        ),
                        GestureDetector(
                            onTap: () {
                              editLinks.value = !editLinks.value;
                            },
                            child: Icon(Icons.edit, color: fieldBorderColor, size: 25,))
                      ],
                    ): Row(
                              children: [
                                Flexible(
                                  child: CommonTextField(
                                    hint: "FindersPage",
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Flexible(
                                  child: CommonTextField(
                                    hint: "https://www.finderspage.com",
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        editLinks.value = !editLinks.value;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Icon(Icons.check_circle_outline, size: 20,
                                          color: fieldBorderColor,),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        editLinks.value = !editLinks.value;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Icon(Icons.remove_circle_outline, size: 20,
                                          color: Colors.red,),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),)),
                    Center(
                      child: CommonButton(
                        onPressed: (){
                         validateUser();
                        },
                        margin: EdgeInsets.only(top: 30, bottom: 20),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        radius: 12,
                        btnTxt: "Update",
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> validateUser()async{
    var model = UserModel();
    model.id = controller.storageHelper.getUserModel()?.user?.id;
    if(controller.profileImagePath.value.isNotEmpty){
      model.image = controller.profileImagePath.value;
    }else{
      model.image = controller.userModel.value?.user?.image;
    }
    if (controller.nameController.text.trim().isNotEmpty) {
      model.first_name = controller.nameController.text.trim().toString();
    }else{
      model.first_name = controller.nameController.text.trim().toString();
    }
    if(controller.coverImagePath.value.isNotEmpty){
      model.cover_img = controller.coverImagePath.value;
    }else{
      model.cover_img = controller.coverImagePath.value;
    }
    if (controller.usernameController.text.trim().isNotEmpty) {
      model.username = controller.usernameController.text.trim().toString();
    }else{
      model.username = controller.usernameController.text.trim().toString();
    }
    if (controller.phoneController.text.trim().isNotEmpty) {
      model.phonenumber = controller.phoneController.text.trim().toString();
    }else{
      model.phonenumber = controller.phoneController.text.trim().toString();
    }
    if (controller.zipController.text.trim().isNotEmpty) {
      model.zipcode = controller.zipController.text.trim().toString();
    }else{
      model.zipcode = controller.zipController.text.trim().toString();
    }
    if (controller.zipController.text.trim().isNotEmpty) {
      model.zipcode = controller.zipController.text.trim().toString();
    }else{
      model.zipcode = controller.zipController.text.trim().toString();
    }
    // model.dob = selectedDOB.value;
    await controller.updateUserApi(model);
  }
}
