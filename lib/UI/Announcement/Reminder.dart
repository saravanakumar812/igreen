import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/ReminderController.dart';
import '../../forms/forms.dart';
import '../../forms/theme.dart';
import 'package:intl/intl.dart';
import '../../routes/app_routes.dart';

class Reminder extends GetView<ReminderController> {
  const Reminder({super.key});

  bool selectableDay(DateTime day) {
    // Allow today, tomorrow, yesterday, and day before yesterday to be selectable
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(Duration(days: 1));
    DateTime dayBeforeYesterday = today.subtract(Duration(days: 2));

    return day.year == today.year &&
        day.month == today.month &&
        (day.day == today.day ||
            day.day == yesterday.day ||
            day.day == dayBeforeYesterday.day);
  }

  Future<void> reminderDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        selectableDayPredicate: selectableDay,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xFF455636),
              hintColor: Color(0xFF455636),
              colorScheme: ColorScheme.light(primary: Color(0xFF455636)),
            ),
            child: child!,
          );
        });
    if (picked != null) {
      controller.reminderDateController.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> startDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        selectableDayPredicate: selectableDay,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xFF455636),
              hintColor: Color(0xFF455636),
              colorScheme: ColorScheme.light(primary: Color(0xFF455636)),
            ),
            child: child!,
          );
        });
    if (picked != null) {
      controller.startDateController.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> endDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        selectableDayPredicate: selectableDay,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xFF455636),
              hintColor: Color(0xFF455636),
              colorScheme: ColorScheme.light(primary: Color(0xFF455636)),
            ),
            child: child!,
          );
        });
    if (picked != null) {
      controller.endDateController.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ReminderController controller = Get.put(ReminderController());
    controller.getReminderList();
    return SafeArea(
        child: Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          controller.userDataProvider.setCurrentStatus('');
          controller.userDataProvider.setCurrentStatus('Add');
          Get.toNamed(AppRoutes.addReminder.toName);
        },
        child: Container(
          width: 45,
          height: 45,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          decoration: BoxDecoration(
              color: AppTheme.secondaryColor,
              borderRadius: BorderRadius.circular(22.5)),
        ),
      ),
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
                  width: 70,
                ),
                const Text(
                  "Reminder ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Spacer(),
                Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                  width: width * 0.2,
                  height: height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : controller.reminderData!.isNotEmpty
                ? SingleChildScrollView(
                    child: RefreshIndicator(
                      onRefresh: controller.refreshData,
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height - 100,
                            child: ListView.builder(
                              itemCount: controller.reminderData.length,
                              itemBuilder: (context, index) {
                                return reviewList(context, index);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                      child: Image.asset(
                        height: 250,
                        width: 250,
                        "assets/images/noData.png",
                      ),
                    ),
                  ),
      ),
    ));
  }
}

Widget reviewList(BuildContext context, int index) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  ReminderController controller = Get.put(ReminderController());
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppTheme.bgPink,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 22,
                      width: 25,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        (index + 1).toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Reminder',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
           controller.reminderData[index].department!.isNotEmpty ?
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width * 0.09,
                    ),
                    Text(
                      "Department: ",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      controller.reminderData[index].department.toString(),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ) : Container(),
                // : Container(),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.09,
                ),
                Text(
                  "Reminder Date : ",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  controller.reminderData[index].reminderDate.toString(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.09,
                ),
                Text(
                  "Comments : ",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  controller.reminderData[index].comments.toString(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.userDataProvider
                        .setReminder(controller.reminderData[index]);

                    controller.userDataProvider.setCurrentStatus('');
                    controller.userDataProvider
                        .setCurrentStatus(controller.completedButtonText.value);
                    controller.updateReminderCall("Completed");
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    width: width * 0.2,
                    height: height * 0.045,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Color.fromARGB(255, 179, 176, 176),
                            width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      controller.completedButtonText.value,
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          letterSpacing: 0.1,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.userDataProvider
                        .setReminder(controller.reminderData[index]);
                    controller.reminderDateController.text =
                        DateFormat('yyyy-MM-dd').format(controller.reminderData[index].reminderDate.toString().isNotEmpty ?
                        DateTime.parse(controller.reminderData[index].reminderDate.toString()) :DateTime.now() );
                    controller.userDataProvider.setCurrentStatus('Update');
                   controller.userDataProvider.setCurrentStatus(controller.updateButtonText.value);
                   print ("true  ${controller.updateButtonText.value}");
                    Dialoge(context);

                    },
                  child: Container(
                    margin: EdgeInsets.only(top: 5, left: 15, right: 15),
                    width: width * 0.2,
                    height: height * 0.045,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Color.fromARGB(255, 179, 176, 176),
                            width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      controller.updateButtonText.value,
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          letterSpacing: 0.1,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ],
  );
}

Future<void> reminderDate(BuildContext context) async {
  ReminderController controller = Get.put(ReminderController());
  DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      //selectableDayPredicate: selectableDay,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xFF455636),
            hintColor: Color(0xFF455636),
            colorScheme: ColorScheme.light(primary: Color(0xFF455636)),
          ),
          child: child!,
        );
      });
  if (picked != null) {
    controller.reminderDateController.text =
        DateFormat('yyyy-MM-dd').format(picked);
    Dialoge(context);

  }
}

void Dialoge(BuildContext context) {
  ReminderController controller = Get.put(ReminderController());
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Do you want Reminder date update ? ',
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600),
          ),
          actions: [
            TextInput(
              height: 100,
              label: "Reminder Date",
              onPressed: () {
                reminderDate(context);
              },
              controller: controller.reminderDateController,
              textInputType: TextInputType.text,
              textColor: Color(0xCC252525),
              hintText: "yyyy-mm-dd",
              sufficIcon: Icon(
                Icons.calendar_month,
              ),
              obscureText: true,
              onTextChange: (String) {
                //controller.reminderDateController.text = controller.userDataProvider.getReminderData!.reminderDate!.toString();
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Button2(
                  widthFactor: 0.28,
                  heightFactor: 0.04,
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Button(
                  widthFactor: 0.28,
                  heightFactor: 0.04,
                  onPressed: () {
                    controller.updateReminder();
                   Get.back();
                  },
                  child: Text(
                    "Yes",
                    style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        );
      });
}