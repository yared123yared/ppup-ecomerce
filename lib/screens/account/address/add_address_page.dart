import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gigpoint/bloc/address/address_bloc.dart';
import 'package:gigpoint/bloc/address/country_states_bloc.dart';
import 'package:gigpoint/bloc/connectivity_listner_bloc.dart';
import 'package:gigpoint/config/validations.dart';
import 'package:gigpoint/model/address.dart';
import 'package:gigpoint/model/country_states.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';
import 'package:gigpoint/widgets/button_widget.dart';
import 'package:gigpoint/widgets/dropdown_widget.dart';
import 'package:gigpoint/widgets/no_network_wrapper.dart';
import 'package:gigpoint/widgets/textfield_widget.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key, this.address}) : super(key: key);
  final AddressList? address;

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  //TextEditingController phoneController = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController addressTypeController = TextEditingController();

  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  //FocusNode phoneFocus = FocusNode();
  FocusNode addressLine1Focus = FocusNode();
  FocusNode cityFocus = FocusNode();
  FocusNode addressLine2Focus = FocusNode();
  FocusNode zipcodeFocus = FocusNode();
  FocusNode addressTypeFocus = FocusNode();

  List<DropdownMenuItem<String>> countryMenuItem = [];
  List<DropdownMenuItem<String>> stateMenuItem = [];
  // List<DropdownMenuItem<String>> addressTypeMenuItem = [];
  List<StatesList> statesList = [];
  CountryStateBloc stateListBloc = getIt<CountryStateBloc>();
  AddressBloc addressBloc = getIt<AddressBloc>();
  bool isCountryLoaded = false;

  ConnectivityListnerBloc connectivityListnerBloc =
      getIt<ConnectivityListnerBloc>();

  List<DropdownMenuItem<String>> generateCountryDropdown() {
    List<DropdownMenuItem<String>> list = [];
    for (String item in Constants.countries) {
      list.add(
        DropdownMenuItem(
          child: Text(item, style: Styles.bold(fontSize: 14)),
          value: item,
        ),
      );
    }
    return list;
  }

  List<DropdownMenuItem<String>> generateStateDropdown(List<StatesList> data) {
    List<DropdownMenuItem<String>> list = [];
    for (StatesList item in data) {
      list.add(
        DropdownMenuItem(
          child: Text(item.stateName ?? '', style: Styles.bold(fontSize: 14)),
          value: item.stateName ?? '',
        ),
      );
    }
    return list;
  }

  // List<DropdownMenuItem<String>> generateAddressTypeDropdown() {
  //   List<DropdownMenuItem<String>> list = [];
  //   for (String item in Constants.addressTypes) {
  //     list.add(
  //       DropdownMenuItem(
  //         child: Text(item, style: Styles.bold(fontSize: 14)),
  //         value: item,
  //       ),
  //     );
  //   }
  //   return list;
  // }

  bool hasFirstNameError = false,
      hasLastNameError = false,
      //hasPhoneError = false,
      hasAddressLine1Error = false,
      // hasAddressLine2Error = false,
      hasCountryError = false,
      hasStateError = false,
      hasCityError = false,
      hasZipcodeError = false,
      hasAddressTypeError = false;

  String? selectedCountry, selectedState, selectedAddressType;

  var regexToRemoveEmoji = RegExp(
      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');

  @override
  void initState() {
    super.initState();
    countryMenuItem = generateCountryDropdown();
    //addressTypeMenuItem = generateAddressTypeDropdown();
    selectedAddressType = Constants.addressTypes[0];
    if (widget.address != null) {
      firstNameController.text = widget.address!.firstName ?? '';
      lastNameController.text = widget.address!.lastName ?? '';
      //phoneController.text = widget.address!.phone ?? '';
      addressLine1Controller.text = widget.address!.addressLine ?? '';
      selectedCountry = Constants.countries[0];
      if (widget.address!.state!.isNotEmpty) {
        selectedState = widget.address!.state;
      } else {
        selectedState = null;
      }
      //selectedAddressType = widget.address!.addressType;
      cityController.text = widget.address!.city ?? '';
      addressLine2Controller.text = widget.address!.addressLine2 ?? '';
      zipcodeController.text = widget.address!.zipcode ?? '';
      stateListBloc.getStateList(selectedCountry ?? '');
      addressTypeController.text = widget.address!.addressType ?? '';
    }
  }

  @override
  void dispose() {
    stateListBloc.dispose();
    addressBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppbarWidget(
          title: widget.address != null ? 'Edit Address' : 'Add New Address',
          actions: const [],
        ),
        bottomNavigationBar: StreamBuilder<bool>(
            stream: connectivityListnerBloc.responseData,
            builder: (context, snapshot) {
              return (snapshot.hasData && snapshot.data!)
                  ? Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: AppTheme.boxShadow,
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: ButtonWidget(
                        name: 'Save',
                        onTap: () => saveAddress(),
                      ),
                    )
                  : const SizedBox();
            }),
        body: NoNetworkWrapper(
          onRefresh: () {
            connectivityListnerBloc.refresh().then((value) {
              stateListBloc.getStateList(selectedCountry ?? '');
            });
          },
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 54),
              children: [
                TextFieldWidget(
                  controller: firstNameController,
                  focusNode: firstNameFocus,
                  nextFocus: lastNameFocus,
                  maxLength: 30,
                  onFocusChange: (val) {
                    setState(() {});
                  },
                  // validator: (val) {
                  //   if (val == null || val.isEmpty) {
                  //     hasFirstNameError = true;
                  //   } else {
                  //     hasFirstNameError = false;
                  //   }
                  //   setState(() {});
                  // },
                  title: 'First Name',
                  hasError: hasFirstNameError,
                  errorText: Validations.ADDRESS_FIRST_NAME_VALIDATION,
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(regexToRemoveEmoji)
                  ],
                ),
                const SizedBox(height: 10),
                TextFieldWidget(
                  controller: lastNameController,
                  focusNode: lastNameFocus,
                  nextFocus: addressLine1Focus,
                  maxLength: 30,
                  onFocusChange: (val) {
                    setState(() {});
                  },
                  // validator: (val) {
                  //   if (val == null || val.isEmpty) {
                  //     hasLastNameError = true;
                  //   } else {
                  //     hasLastNameError = false;
                  //   }
                  //   setState(() {});
                  // },
                  title: 'Last Name',
                  hasError: hasLastNameError,
                  errorText: Validations.ADDRESS_LAST_NAME_VALIDATION,
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(regexToRemoveEmoji)
                  ],
                ),
                const SizedBox(height: 10),
                TextFieldWidget(
                  controller: addressLine1Controller,
                  focusNode: addressLine1Focus,
                  maxLength: 40,
                  nextFocus: addressLine2Focus,
                  onFocusChange: (val) {
                    setState(() {});
                  },
                  // validator: (val) {
                  //   if (val == null || val.isEmpty) {
                  //     hasAddressLine1Error = true;
                  //   } else {
                  //     hasAddressLine1Error = false;
                  //   }
                  //   setState(() {});
                  // },
                  title: 'Adddress Line 1',
                  hasError: hasAddressLine1Error,
                  errorText: Validations.ADDRESS_ADDRESS_LINE_1_VALIDATION,
                  textInputType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(regexToRemoveEmoji)
                  ],
                ),
                const SizedBox(height: 10),
                TextFieldWidget(
                  controller: addressLine2Controller,
                  focusNode: addressLine2Focus,
                  nextFocus: FocusNode(),
                  maxLength: 40,
                  onFocusChange: (val) {
                    setState(() {});
                  },
                  // validator: (val) {
                  //   if (val == null || val.isEmpty) {
                  //     hasAddressLine2Error = true;
                  //   } else {
                  //     hasAddressLine2Error = false;
                  //   }
                  //   setState(() {});
                  // },
                  title: 'Address Line 2',
                  // hasError: hasAddressLine2Error,
                  textInputType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(regexToRemoveEmoji)
                  ],
                ),
                const SizedBox(height: 10),
                /* TextFieldWidget(
                  controller: phoneController,
                  focusNode: phoneFocus,
                  maxLength: 40,
                  nextFocus: FocusNode(),
                  onFocusChange: (val) {
                    setState(() {});
                  },
                  // validator: (val) {
                  //   if (val == null || val.isEmpty) {
                  //     hasPhoneError = true;
                  //   } else {
                  //     hasPhoneError = false;
                  //   }
                  //   setState(() {});
                  // },
                  title: 'Phone',
                  hasError: hasPhoneError,
                  errorText: 'Invalid data. Please re-enter',
                  textInputType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 10),*/
                DropdownWidget(
                  title: 'Country',
                  value: selectedCountry,
                  items: countryMenuItem,
                  hasError: hasCountryError,
                  errorText: Validations.ADDRESS_COUNTRY_VALIDATION,
                  onChanged: (val) {
                    stateListBloc.getStateList(val);
                    setState(() {
                      ///Clear the [selectedState] only if the selected country is different.
                      if (selectedCountry != val) {
                        selectedState = null;
                      }
                      selectedCountry = val;
                      isCountryLoaded = true;
                    });
                  },
                ),
                const SizedBox(height: 10),
                StreamBuilder<List<StatesList>>(
                    stream: stateListBloc.responseData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        stateMenuItem =
                            generateStateDropdown(snapshot.data ?? []);
                      } else if (snapshot.connectionState ==
                              ConnectionState.waiting &&
                          isCountryLoaded) {
                        return const Center(child: LinearProgressIndicator());
                      }

                      return DropdownWidget(
                        title: 'State/Province',
                        value: selectedState,
                        items: stateMenuItem.toSet().toList(),
                        hasError: hasStateError,
                        errorText: Validations.ADDRESS_STATE_VALIDATION,
                        onChanged: (val) {
                          setState(() {
                            selectedState = val;
                          });
                        },
                      );
                    }),
                const SizedBox(height: 10),
                TextFieldWidget(
                  controller: cityController,
                  focusNode: cityFocus,
                  nextFocus: zipcodeFocus,
                  maxLength: 10,
                  onFocusChange: (val) {
                    setState(() {});
                  },
                  // validator: (val) {
                  //   if (val == null || val.isEmpty) {
                  //     hasCityError = true;
                  //   } else {
                  //     hasCityError = false;
                  //   }
                  //   setState(() {});
                  // },
                  title: 'City',
                  hasError: hasCityError,
                  errorText: Validations.ADDRESS_CITY_VALIDATION,
                  textInputType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(regexToRemoveEmoji)
                  ],
                ),
                const SizedBox(height: 10),
                TextFieldWidget(
                  controller: zipcodeController,
                  focusNode: zipcodeFocus,
                  nextFocus: addressTypeFocus,
                  maxLength: 10,
                  onFocusChange: (val) {
                    setState(() {});
                  },
                  // validator: (val) {
                  //   if (val == null || val.isEmpty) {
                  //     hasZipcodeError = true;
                  //   } else {
                  //     hasZipcodeError = false;
                  //   }
                  //   setState(() {});
                  // },
                  title: 'Zip/Postal Code',
                  hasError: hasZipcodeError,
                  errorText: Validations.ADDRESS_ZIPCODE_VALIDATION,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z]')),
                  ],
                ),
                const SizedBox(height: 10),
                TextFieldWidget(
                  controller: addressTypeController,
                  focusNode: addressTypeFocus,
                  nextFocus: FocusNode(),
                  onFocusChange: (val) {
                    setState(() {});
                  },
                  // validator: (val) {
                  //   if (val == null || val.isEmpty) {
                  //     hasAddressTypeError = true;
                  //   } else {
                  //     hasAddressTypeError = false;
                  //   }
                  //   setState(() {});
                  // },
                  title: 'Address Type',
                  hasError: hasAddressTypeError,
                  errorText: Validations.ADDRESS_ADDRESS_TYPE_VALIDATION,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(regexToRemoveEmoji)
                  ],
                ),
                /*DropdownWidget(
                  title: 'Address Type',
                  value: selectedAddressType,
                  items: addressTypeMenuItem,
                  hasError: false,
                  errorText: 'Invalid data. Please re-enter',
                  onChanged: (val) {
                    setState(() {
                      selectedAddressType = val;
                    });
                  },
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveAddress() async {
    if (firstNameController.text.isEmpty) {
      hasFirstNameError = true;
    } else {
      hasFirstNameError = false;
    }
    if (lastNameController.text.isEmpty) {
      hasLastNameError = true;
    } else {
      hasLastNameError = false;
    }
    if (addressLine1Controller.text.isEmpty) {
      hasAddressLine1Error = true;
    } else {
      hasAddressLine1Error = false;
    }
    /*if (addressLine2Controller.text.isEmpty) {
      hasAddressLine2Error = true;
    } else {
      hasAddressLine2Error = false;
    }*/
/*    if (phoneController.text.isEmpty) {
      hasPhoneError = true;
    } else {
      hasPhoneError = false;
    }*/
    if (selectedCountry == null) {
      hasCountryError = true;
    } else {
      hasCountryError = false;
    }
    if (selectedState == null) {
      hasStateError = true;
    } else {
      hasStateError = false;
    }
    if (cityController.text.isEmpty) {
      hasCityError = true;
    } else {
      hasCityError = false;
    }
    if (zipcodeController.text.isEmpty) {
      hasZipcodeError = true;
    } else {
      hasZipcodeError = false;
    }
    if (addressTypeController.text.isEmpty) {
      hasAddressTypeError = true;
    } else {
      hasAddressTypeError = false;
    }
    setState(() {});
    if (!hasFirstNameError &&
        !hasLastNameError &&
        //!hasPhoneError &&
        !hasAddressLine1Error &&
        // !hasAddressLine2Error &&
        !hasCountryError &&
        !hasStateError &&
        !hasCityError &&
        !hasZipcodeError &&
        !hasAddressTypeError) {
      AddressList address = AddressList();
      address.firstName = firstNameController.text;
      address.lastName = lastNameController.text;
      address.addressLine = addressLine1Controller.text;
      address.addressLine2 = addressLine2Controller.text;
      address.country = selectedCountry;
      address.state = selectedState;
      address.city = cityController.text;
      address.zipcode = zipcodeController.text;
      address.addressType = addressTypeController.text;
      //address.phone = phoneController.text;
      if (await connectivityListnerBloc.getNetworkStatus()) {
        if (widget.address != null) {
          address.id = widget.address!.id;
          await addressBloc.editAddress(context, address);
        } else {
          await addressBloc.addAddress(context, address);
        }
      } else {
        AppUtils.showErrorSnackbar(context, Validations.NO_NETWORK);
      }
    }
  }
}
