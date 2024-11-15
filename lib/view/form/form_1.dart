import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mind_bend_doc/Model/MOU_model.dart';
import 'package:mind_bend_doc/components/text_field.dart';
import 'package:mind_bend_doc/theme/app_theme.dart';
import '../pdf_preview/preview.dart';

class MOUform extends StatefulWidget {
  MOUform({super.key});

  @override
  State<MOUform> createState() => _MOUformState();
}

class _MOUformState extends State<MOUform> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _orgNameController = TextEditingController();
  final _orgAddressController = TextEditingController();
  final _orgContactController = TextEditingController();
  final _orgPhoneController = TextEditingController();
  final _orgEmailController = TextEditingController();
  final _promisedByUs = TextEditingController();
  final _promisedByOrg = TextEditingController();
  final _lastValidDateController = TextEditingController();

  List<DateTime?> _dialogCalendarPickerValue = [DateTime.now()];
  List<DateTime?> _dialogCalendarLastValidDateValue = [DateTime.now()];

  String formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);


  // Open the date picker dialog with specific width and height constraints
  Future<void> _showCustomDatePicker(BuildContext context) async {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final pickedDates = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Date"),
          content: SizedBox(
            width: screenWidth * 0.9,
            height: screenHeight * 0.5,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: <Widget>[
                Flexible(
                  child: CalendarDatePicker2(
                    config: CalendarDatePicker2Config(
                      calendarType: CalendarDatePicker2Type.single,
                      selectedDayHighlightColor: Colors.blue,
                      weekdayLabelTextStyle: const TextStyle(color: Colors.black),
                    ),
                    value: _dialogCalendarPickerValue,
                    onValueChanged: (dates) {
                      setState(() {
                        _dialogCalendarPickerValue = dates;
                        if (dates.isNotEmpty && dates.first != null) {
                          _dateController.text = "${dates.first!.toLocal()}".split(' ')[0];
                        }
                      });
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () { Navigator.pop(context); },
                  child: Text("ok"),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (pickedDates != null && pickedDates.isNotEmpty && pickedDates.first != null) {
      setState(() {
        _dialogCalendarPickerValue = pickedDates;
        _dateController.text = "${pickedDates.first!.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _showLastValidDatePicker(BuildContext context) async {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final pickedDates = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Last Valid Date"),
          content: SizedBox(
            width: screenWidth * 0.9,
            height: screenHeight * 0.5,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: <Widget>[
                Flexible(
                  child: CalendarDatePicker2(
                    config: CalendarDatePicker2Config(
                      calendarType: CalendarDatePicker2Type.single,
                      selectedDayHighlightColor: Colors.blue,
                      weekdayLabelTextStyle: const TextStyle(color: Colors.black),
                    ),
                    value: _dialogCalendarLastValidDateValue,
                    onValueChanged: (dates) {
                      setState(() {
                        _dialogCalendarLastValidDateValue = dates;
                        if (dates.isNotEmpty && dates.first != null) {
                          _lastValidDateController.text = "${dates.first!.toLocal()}".split(' ')[0];
                        }
                      });
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () { Navigator.pop(context); },
                  child: Text("ok"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<String> _parseStr(String str) {
    List<String> sentences = str.split('.');
    sentences = sentences.where((sentence) => sentence.isNotEmpty).toList();
    return sentences;
  }

  // Handle form submission and navigate to the preview screen
  void _submitForm(BuildContext context) {
    print("Submit button pressed"); // This should print when the function is triggered
    print(_dateController.text);


    if (_formKey.currentState!.validate()) {
      final mouData = MouModel(
        date: _dateController.text,
        orgName: _orgNameController.text,
        orgAddress: _orgAddressController.text,
        orgContact: _orgContactController.text,
        orgPhone: _orgPhoneController.text,
        orgEmail: _orgEmailController.text,
        mbPromised: _parseStr(_promisedByUs.text.trim()),
        orgPromised: _parseStr(_promisedByOrg.text.trim()),
        lastValidDate: _lastValidDateController.text,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewScreen(mouData: mouData),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 60,
                    color: AppTheme.lightPrimaryColor,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "MOU Content",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Date Picker Field
                  TextFormField(
                    controller: _dateController,
                    readOnly: true,
                    onTap: () => _showCustomDatePicker(context),
                    decoration: InputDecoration(
                      labelText: "Select Date",
                      border: OutlineInputBorder(),
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                    validator: (val) => _dialogCalendarPickerValue.first == null
                        ? "Please select a date"
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // Organization Name
                  InputTextField(
                    title: "Organization Name",
                    textEditingController: _orgNameController,
                    textInputType: TextInputType.text,
                    validation: (val) => val == null || val.isEmpty ? "Please enter the organization name" : null,
                  ),
                  const SizedBox(height: 16),

                  // Organization Address
                  InputTextField(
                    title: "Organization Address",
                    textEditingController: _orgAddressController,
                    textInputType: TextInputType.multiline,
                    validation: (val) => val == null || val.isEmpty ? "Please enter the organization address" : null,
                  ),
                  const SizedBox(height: 16),

                  // Point of Contact
                  InputTextField(
                    title: "Point of Contact",
                    textEditingController: _orgContactController,
                    textInputType: TextInputType.text,
                    validation: (val) => val == null || val.isEmpty ? "Please enter the point of contact name" : null,
                  ),
                  const SizedBox(height: 16),

                  // Phone Number
                  InputTextField(
                    title: "Phone Number",
                    textEditingController: _orgPhoneController,
                    textInputType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validation: (val) => val == null || val.length < 10 ? "Please enter a valid phone number" : null,
                  ),
                  const SizedBox(height: 16),

                  // Email Address
                  InputTextField(
                    title: "Email Address",
                    textEditingController: _orgEmailController,
                    textInputType: TextInputType.emailAddress,
                    validation: (val) => val != null && val.contains('@') ? null : "Please enter a valid email address",
                  ),
                  const SizedBox(height: 16),

                  //promised by us
                  InputTextField(
                    title: "Things Promised By MindBend",
                    textEditingController: _promisedByUs,
                    textInputType: TextInputType.multiline,
                    validation: (val) => val == null || val.isEmpty ? "Please enter the data" : null,
                  ),

                  //promised by org
                  const SizedBox(height: 16),

                  InputTextField(
                    title: "Things Promised By Organization",
                    textEditingController: _promisedByOrg,
                    textInputType: TextInputType.multiline,
                    validation: (val) => val == null || val.isEmpty ? "Please enter the data" : null,
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _lastValidDateController,
                    readOnly: true,
                    onTap: () => _showLastValidDatePicker(context),
                    decoration: InputDecoration(
                      labelText: "Last Valid Date for MOU",
                      border: OutlineInputBorder(),
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                    validator: (val) => _dialogCalendarLastValidDateValue.first == null
                        ? "Please select a last valid date"
                        : null,
                  ),

                  const SizedBox(height: 16,),

                  // Submit Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _submitForm(context),
                      child: const Text("Preview and Generate PDF"),
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
