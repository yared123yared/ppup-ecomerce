import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gigpoint/bloc/contact_us/contact_us_bloc.dart';
import 'package:gigpoint/config/validations.dart';
import 'package:gigpoint/model/contact_us.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';
import 'package:gigpoint/widgets/button_widget.dart';
import 'package:gigpoint/widgets/filter_modal_sheet.dart';
import 'package:gigpoint/widgets/textfield_widget.dart';
import 'write_filter_card.dart';

class WriteToUsPage extends StatefulWidget {
  const WriteToUsPage({Key? key, this.contactUsList}) : super(key: key);
  final List<ContactUsList>? contactUsList;

  @override
  _WriteToUsPageState createState() => _WriteToUsPageState();
}

class _WriteToUsPageState extends State<WriteToUsPage> {
  String dropdownCategory = 'Select Category';
  String dropdownSubject = 'Subject';
  TextEditingController chooseSubjectController = TextEditingController();
  TextEditingController explainIssueController = TextEditingController();
  ContactUsBloc contactUsBloc = getIt<ContactUsBloc>();
  int? selectedCatId = 0;

  bool hasChooseSubjectError = false,
      hasExplainIssueError = false,
      hasCategoryError = false;

  FocusNode chooseSubject = FocusNode();
  FocusNode explainIssue = FocusNode();
  var regexToRemoveEmoji = RegExp(
      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');

  @override
  void dispose() {
    super.dispose();
    contactUsBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const AppbarWidget(
          title: 'Write to Us',
          actions: [],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ListView(
            children: [
              const SizedBox(height: 24),
              WriteToFilterCard(
                  title: dropdownCategory,
                  hasError: hasCategoryError,
                  errorText: Validations.SELECT_CATEGORY_VALIDATION,
                  onTap: () {
                    setState(() {
                      showSortBy();
                    });
                  }),
              const SizedBox(height: 12),
              TextFieldWidget(
                  controller: chooseSubjectController,
                  focusNode: chooseSubject,
                  nextFocus: explainIssue,
                  title: dropdownSubject,
                  hint: dropdownSubject,
                  maxLength: 40,
                  onChanged: (String value) {
                    if (value.isEmpty) {
                      setState(() {
                        hasChooseSubjectError = true;
                      });
                    } else {
                      setState(() {
                        hasChooseSubjectError = false;
                      });
                    }
                  },
                  hasError: hasChooseSubjectError,
                  errorText: Validations.ISSUE_SUBJECT_VALIDATION,
                  textInputType: TextInputType.multiline,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(regexToRemoveEmoji)
                  ],
                  onFocusChange: (val) {
                    setState(() {});
                  }),
              const SizedBox(height: 12),
              TextFieldWidget(
                controller: explainIssueController,
                focusNode: explainIssue,
                nextFocus: FocusNode(),
                title: 'Explain your issue in detail here',
                hint: 'Explain your issue in detail here',
                maxLength: 300,
                maxLines: 6,
                onChanged: (String value) {
                  if (value.isEmpty) {
                    setState(() {
                      hasExplainIssueError = true;
                    });
                  } else {
                    setState(() {
                      hasExplainIssueError = false;
                    });
                  }
                },
                hasError: hasExplainIssueError,
                errorText: Validations.DETAILED_ISSUE_VALIDATION,
                textInputType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                textCapitalization: TextCapitalization.words,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(regexToRemoveEmoji)
                ],
                onFocusChange: (val) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 44),
              ButtonWidget(
                  name: 'Submit',
                  onTap: () async {
                    if (chooseSubjectController.text.isEmpty) {
                      hasChooseSubjectError = true;
                    } else {
                      hasChooseSubjectError = false;
                    }
                    if (explainIssueController.text.isEmpty) {
                      hasExplainIssueError = true;
                    } else {
                      hasExplainIssueError = false;
                    }
                    if (selectedCatId == 0) {
                      hasCategoryError = true;
                    } else {
                      hasCategoryError = false;
                    }

                    setState(() {});

                    if (!hasChooseSubjectError && !hasExplainIssueError) {
                      await contactUsBloc.submitContactUs(
                          context,
                          selectedCatId!,
                          chooseSubjectController.text,
                          explainIssueController.text);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  showSortBy() async {
    List<Filter> filterOptions = [];
    for (var item in widget.contactUsList!) {
      filterOptions.add(
          Filter(item.category!, item.category.toString(), item.id.toString()));
    }
    final result = await FilterModalSheet.filterBy(
        context, 'Select Category', filterOptions, dropdownCategory);
    dropdownCategory = result;
    setState(() {});
    int index = widget.contactUsList!
        .indexWhere((element) => element.category == dropdownCategory);
    setState(() {
      selectedCatId = widget.contactUsList?[index].id;
      if (selectedCatId != 0) hasCategoryError = false;
    });
  }
}
