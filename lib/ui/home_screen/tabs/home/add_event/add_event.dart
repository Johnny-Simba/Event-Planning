import 'package:event_planning/firebase_utils.dart';
import 'package:event_planning/model/event.dart';
import 'package:event_planning/providers/event_list_provider.dart';
import 'package:event_planning/providers/user_provider.dart';
import 'package:event_planning/ui/home_screen/tabs/home/tab_event_widget.dart';
import 'package:event_planning/ui/widget/custom_elevated_button.dart';
import 'package:event_planning/ui/widget/custom_text_field.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../providers/app_theme_provider.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_styles.dart';


class AddEvent extends StatefulWidget {
  static const String routeName = 'Add Event';

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int selectedIndex = 0;
  final formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  DateTime? selectedDate;
  String formatedDate = '';
  TimeOfDay? selectedTime;
  String formatedTime = '';
  String errorDateMessage = '';
  String errorTimeMessage = '';
  String selectedImage = '';
  String selectedEvent = '';
  late EventListProvider eventListProvider;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    eventListProvider = Provider.of<EventListProvider>(context);

    List<String> eventNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.eating,
      AppLocalizations.of(context)!.workshop
    ];
    List<String> selectedImageName = [
      AssetsManager.sportImage,
      AssetsManager.birthdayImage,
      AssetsManager.meetingImage,
      AssetsManager.holidayImage,
      AssetsManager.exhibitionImage,
      AssetsManager.bookClubImage,
      AssetsManager.gamingImage,
      AssetsManager.eatingImage,
      AssetsManager.workshopImage,
    ];
    selectedImage = selectedImageName[selectedIndex];
    selectedEvent = eventListProvider.eventKeyNameList[selectedIndex];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        title: Text(AppLocalizations.of(context)!.create_event,
          style: themeProvider.appTheme == ThemeMode.light ?
          AppStyles.regular20Black : AppStyles.regular20White,),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: themeProvider.appTheme ==
              ThemeMode.dark ? AppColors.whiteColor : AppColors.blackColor,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.04,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height * 0.24,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(selectedImageName[selectedIndex]),
              ),
              SizedBox(height: height * 0.019,),
              Container(
                height: height * 0.035,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          selectedIndex = index;
                          setState(() {
          
                          });
                        },
                        splashColor: AppColors.transparentColor,
                        child: TabEventWidget(
                          isSelected: selectedIndex == index,
                          eventName: eventNameList[index],
                          backgroundColor: AppColors.primaryLight,
                          borderColor: AppColors.primaryLight,
                          textSelectedStyle: AppStyles.medium16White,
                          textUnSelectedStyle: AppStyles.medium16Primary,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: width * 0.025,);
                    },
                    itemCount: eventNameList.length
                ),
              ),
              SizedBox(height: height * 0.019,),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(AppLocalizations.of(context)!.title ,
                      style: themeProvider.appTheme == ThemeMode.light ?
                      AppStyles.medium16Black : AppStyles.medium16White,),
                    SizedBox(height: height * 0.0095,),
                    CustomTextField(
                      controller: titleController,
                      validator: (text) {
                        if(text == null || text.isEmpty){
                          return 'Please Enter Event Title';
                        }
                        return null;
                      },
                      hintText: AppLocalizations.of(context)!.event_title,
                      borderColor: themeProvider.appTheme == ThemeMode.light ?
                      AppColors.blackColor : AppColors.whiteColor,
                      hintStyle: themeProvider.appTheme == ThemeMode.light ?
                        AppStyles.medium16Gray : AppStyles.medium16White,
                      prefixIcon: Image.asset(AssetsManager.eventTitleIcon,
                        color: themeProvider.appTheme == ThemeMode.light ?
                        AppColors.grayColor : AppColors.whiteColor,),
                    ),
                    SizedBox(height: height * 0.019,),
                    Text(AppLocalizations.of(context)!.description ,
                        style: themeProvider.appTheme == ThemeMode.light ?
                        AppStyles.medium16Black : AppStyles.medium16White,),
                    SizedBox(height: height * 0.0095,),
                    CustomTextField(
                      controller: descriptionController,
                      validator: (text) {
                        if(text == null || text.isEmpty){
                          return 'Please Enter Event Description';
                        }
                        return null;
                      },
                      hintText: AppLocalizations.of(context)!.event_description,
                      borderColor: themeProvider.appTheme == ThemeMode.light ?
                      AppColors.grayColor : AppColors.whiteColor,
                      hintStyle: themeProvider.appTheme == ThemeMode.light ?
                      AppStyles.medium16Gray : AppStyles.medium16White,
                      maxLines: 4,
                    ),
                    SizedBox(height: height * 0.019,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(AssetsManager.dateIcon,
                              color: themeProvider.appTheme == ThemeMode.light ?
                              AppColors.blackColor : AppColors.whiteColor,),
                            SizedBox(width: width * 0.025,),
                            Text(AppLocalizations.of(context)!.event_date,
                              style: themeProvider.appTheme == ThemeMode.light ?
                              AppStyles.medium16Black : AppStyles.medium16White,)
                          ],
                        ),
                        InkWell(
                          onTap: chooseDate,
                          child: Row(
                            children: [
                              Text( selectedDate == null ?
                                AppLocalizations.of(context)!.choose_date :
                              DateFormat('dd/MM/yyyy').format(selectedDate!),
                                style: AppStyles.medium16Primary,),
                            ],
                          ),
                        )
                      ],
                    ),
                    if (errorDateMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          textAlign: TextAlign.end,
                          errorDateMessage,
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                    SizedBox(height: height * 0.019,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(AssetsManager.timeIcon,
                            color:themeProvider.appTheme == ThemeMode.light ?
                            AppColors.blackColor : AppColors.whiteColor,),
                            SizedBox(width: width * 0.025,),
                            Text(AppLocalizations.of(context)!.event_time,
                              style: themeProvider.appTheme == ThemeMode.light ?
                              AppStyles.medium16Black : AppStyles.medium16White,)
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                                onTap: chooseTime,
                                child: Text( selectedTime == null ?
                                  AppLocalizations.of(context)!.choose_time :
                                  formatedTime,
                                  style: AppStyles.medium16Primary,)),
                          ],
                        )
                      ],
                    ),
                    if (errorTimeMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          textAlign: TextAlign.end,
                          errorTimeMessage,
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                    SizedBox(height: height * 0.021,),
                    Text(AppLocalizations.of(context)!.location ,
                      style: themeProvider.appTheme == ThemeMode.light ?
                      AppStyles.medium16Black : AppStyles.medium16White,),
                    SizedBox(height: height * 0.0095,),
                    InkWell(
                      onTap: () {

                      },
                      child: Container(
                        height: height * 0.07,
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.02,
                          vertical: height * 0.009,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                width: 2,
                                color: AppColors.primaryLight
                            )
                        ),
                        child: Row(
                          children: [
                            Image.asset(AssetsManager.locationIcon,),
                            SizedBox(width: width * 0.02,),
                            Text(AppLocalizations.of(context)!.choose_event_location,style: AppStyles.medium16Primary,),
                            SizedBox(width: width * 0.28),
                            Image.asset(AssetsManager.arrowLocationIcon)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.019,),
                    CustomElevatedButton(
                      onButtonClicked: addEvent,
                      mainAxisAlignment: MainAxisAlignment.center,
                      buttonText: AppLocalizations.of(context)!.add_event,
                    )
                  ],
                ),

              )
            ],
          ),
        ),
      ),
    );
  }
  void addEvent(){
    if(formKey.currentState?.validate() == true && validateDate() && validateTime()){
      Event event = Event(
          title: titleController.text,
          description: descriptionController.text,
          image: selectedImage,
          eventName: selectedEvent,
          dateTime: selectedDate!,
          time: formatedTime,
      );
      var userProvider = Provider.of<UserProvider>(context, listen:  false);
      FirebaseUtils.addEventToFireStore(event, userProvider.currentUser!.id).
      then((value) {
        print('event added successfully');
        eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
        Navigator.of(context).pop();
      },);
    }
    else{
      validateDate();
      validateTime();
    }
  }
  void chooseDate() async{
    var chooseDate = await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    selectedDate = chooseDate;
    formatedDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
    setState(() {

    });
  }
  void chooseTime() async{
    var chooseTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
    );
    selectedTime = chooseTime;
    formatedTime = selectedTime!.format(context);
    setState(() {

    });
  }
  bool validateDate() {
    if (selectedDate == null) {
      setState(() {
        errorDateMessage = "Please choose a date.";
      });
      return false;
    } else {
      setState(() {
        errorDateMessage = ""; // Clear error message
      });
      return true;
    }
  }
  bool validateTime(){
    if (selectedTime == null) {
      setState(() {
        errorTimeMessage = "Please choose a Time.";
      });
      return false;
    } else {
      setState(() {
        errorTimeMessage = ""; // Clear error message
      });
      return true;
    }
  }
}
