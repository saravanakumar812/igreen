import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/WageEmployeeDetailsController.dart';
import '../../Utils/image_picker.dart';
import '../../forms/forms.dart';
import '../../forms/theme.dart';
import '../../routes/app_routes.dart';

class WageEmployeeDetails extends GetView<WageEmployeeDetailsController> {
  const WageEmployeeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    WageEmployeeDetailsController controller =
        Get.put(WageEmployeeDetailsController());
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppTheme.screenBackground,
      appBar: PreferredSize(
        preferredSize: Size(100, 70),
        child: AppBar(
          backgroundColor: AppTheme.screenBackground,
          automaticallyImplyLeading: false,
          bottomOpacity: 0.0,
          elevation: 0.0,
          flexibleSpace: Container(
            height: 80,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0.0),
                bottomRight: Radius.circular(0.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 23,
                            ),
                            Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      )),
                ),
                const SizedBox(
                  width: 54,
                ),
                Text(
                  "Wage Employee Details",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Spacer(),
                Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                  width: width * 0.3,
                  height: height * 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: AppTheme.screenBackground,
            child: Column(
              children: [
                TextInput(
                  height: 100,
                  label: "Employee Name",
                  onPressed: () {},
                  controller: controller.employeeNameController,
                  textInputType: TextInputType.text,
                  textColor: Color(0xCC252525),
                  hintText: "Enter Employee Name",
                  onTextChange: (val) {
                    // controller.popUpValue.value = true;
                    // controller.wagesEmployeesList[index].employeeName = val;
                  },
                ),
                TextInput(
                  height: 100,
                  label: "amount",
                  onPressed: () {},
                  controller: controller.amountController,
                  textInputType: TextInputType.number,
                  textColor: Color(0xCC252525),
                  hintText: "Enter amount",
                  onTextChange: (val) {
                    // controller.popUpValue.value = true;
                    // controller.wagesEmployeesList[index].amount = int.parse(val);
                  },
                ),
                TextInput(
                  height: 100,
                  label: "Contact Number",
                  onPressed: () {},
                  controller: controller.contactNumberController,
                  textInputType: TextInputType.number,
                  textColor: Color(0xCC252525),
                  hintText: "Enter Contact Number",
                  onTextChange: (val) {
                    // controller.popUpValue.value = true;
                    // controller.wagesEmployeesList[index].contactNumber =
                    //     int.parse(val);
                  },
                ),
                Obx(
                      () => Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: AppTheme.liteWhite),
                    ),
                    child: Container(
                      height:
                      MediaQuery.of(context).size.height * 0.12,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: controller.pickImageSelectedEmp.value
                            ? null
                            : Border.all(
                            color: AppTheme.liteWhite, width: 3),
                      ),
                      child: Material(
                        color: AppTheme.liteWhite,
                        child: InkWell(
                          onTap: () {
                            Get.to(
                              ImagePick(
                                isMultiple: true,
                                title: " Bill Image ",
                                onClose: () => Get.back(),
                                onSave: (List<PickedImage> images) {
                                  if (images.isNotEmpty) {
                                    controller.itemImagePickEmp.value =
                                    images[0];
                                    controller.pickImageSelectedEmp
                                        .value = true;
                                  }
                                  Get.back();
                                },
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              controller.itemImagePickEmp.value !=
                                  null &&
                                  controller.itemImagePickEmp.value
                                      .imagePath !=
                                      null?
                              Image.file(
                                controller.itemImagePickEmp!.value!
                                    .imagePath,
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ):

                              controller.imagePathFromData.value.isNotEmpty &&
                                  controller.isUpdateImageAvailable.value ?
                              Image.network(
                                controller.imagePathFromData.value,
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ):
                              Center(
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image,
                                      size: 50,
                                    ),
                                    Text(
                                      "Bill",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight:
                                          FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                    child: Button(
                        widthFactor: 0.9,
                        heightFactor: 0.06,
                        onPressed: () {
                          controller.empUpdate();

                        },
                        child: Text('Edit',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w600,
                            )))),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
