import 'package:event_planning/ui/home_screen/tabs/home_screen.dart';
import 'package:event_planning/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../firebase_utils.dart';
import '../../../../../model/event.dart';
import '../../../../../providers/app_theme_provider.dart';
import '../../../../../providers/event_list_provider.dart';
import '../../../../../providers/event_provider.dart';
import '../../../../../providers/user_provider.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_styles.dart';
import '../../../../../utils/assets_manager.dart';
import '../../../../widget/custom_elevated_button.dart';
import '../../../../widget/custom_text_field.dart';
import '../tab_event_widget.dart';

class EditEvent extends StatefulWidget {
  static const String routeName = 'Edit Event';


  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {

  int selectedIndex = 0;
  TextEditingController? titleController;
  TextEditingController? descriptionController;
  DateTime? selectedDate;
  String formatedDate = '';
  TimeOfDay? selectedTime;
  String formatedTime = '';
  String? selectedImage;
  String? selectedEvent;
  String? eventId;
  bool? isFavorite;
  late EventListProvider eventListProvider;
  late EventProvider eventProvider;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    eventProvider = Provider.of<EventProvider>(context);
    if(titleController == null || descriptionController == null){
      titleController = TextEditingController(text: eventProvider.event!.title);
      descriptionController = TextEditingController(text: eventProvider.event!.description);
    }
    selectedDate ??= eventProvider.event!.dateTime;
    eventId ??= eventProvider.event!.id;
    isFavorite ??= eventProvider.event!.isFavorite;
    formatedDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
    formatedTime == '' ? formatedTime = eventProvider.event!.time : formatedTime;
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
    selectedImage = selectedImage == null ? selectedImage = eventProvider.event!.image : selectedImage = selectedImageName[selectedIndex];
    selectedEvent = selectedEvent == null ? selectedEvent = eventProvider.event!.eventName : selectedEvent = eventListProvider.eventKeyNameList[selectedIndex];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        title: Text(AppLocalizations.of(context)!.edit_event,
          style: themeProvider.appTheme == ThemeMode.light ?
          AppStyles.regular20Primary : AppStyles.regular20White,),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: themeProvider.appTheme ==
              ThemeMode.dark ? AppColors.whiteColor : AppColors.primaryLight,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
        ),
        child: NotificationListener(
          onNotification: (notification) {
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height * 0.24,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(selectedImage!),
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
                            isSelected: selectedIndex == 0
                                ? eventListProvider.eventKeyNameList[index] == selectedEvent :
                            selectedIndex == index,
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
                        style: themeProvider.appTheme == ThemeMode.light ?
                        AppStyles.medium16Black : AppStyles.medium16White,
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
                        style: themeProvider.appTheme == ThemeMode.light ?
                        AppStyles.medium16Black : AppStyles.medium16White,
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
                                Text(formatedDate,
                                  style: AppStyles.medium16Primary,),
                              ],
                            ),
                          )
                        ],
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
                                  eventProvider.event!.time : formatedTime,style: AppStyles.medium16Primary,)),
                            ],
                          )
                        ],
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(AssetsManager.locationIcon,),
                                  SizedBox(width: width * 0.02,),
                                  Text(AppLocalizations.of(context)!.choose_event_location,style: AppStyles.medium16Primary,),
                                ],
                              ),
                              Row(children: [Image.asset(AssetsManager.arrowLocationIcon)],)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.019,),
                      CustomElevatedButton(
                        onButtonClicked: confirmTheUpdate,
                        mainAxisAlignment: MainAxisAlignment.center,
                        buttonText: AppLocalizations.of(context)!.update_event,
                      ),
                      SizedBox(height: height * 0.019,),
                    ],
                  ),

                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void confirmTheUpdate(){
    DialogUtils.showMessage(context: context,
        message: "This event's data will be updated, and the old data will be lost. Do you agree?",
        posActionName: 'Save Changes', negActionName: 'Discard', posAction: (){
      updateEvent();
        },title: 'Confirm The Update');

  }

  void updateEvent(){
    if(formKey.currentState?.validate() == true){
      Event event = Event(
        id: eventId!,
        title: titleController!.text,
        description: descriptionController!.text,
        image: selectedImage!,
        eventName: selectedEvent!,
        dateTime: selectedDate!,
        time: formatedTime,
        isFavorite: isFavorite!,
      );
      var userProvider = Provider.of<UserProvider>(context, listen:  false);
      FirebaseUtils.updateEventInFireStore(event, userProvider.currentUser!.id);
      eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
      eventProvider.updateEvent(event);
      Navigator.of(context).pop();
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
}
