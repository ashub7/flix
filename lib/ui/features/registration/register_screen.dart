import 'dart:io';

import 'package:flix/core/extension/build_context_ext.dart';
import 'package:flix/core/extension/color_extension.dart';
import 'package:flix/core/extension/date_time_extension.dart';
import 'package:flix/ui/config/app_router.dart';
import 'package:flix/ui/config/rout_names.dart';
import 'package:flix/ui/features/registration/bloc/registration_bloc.dart';
import 'package:flix/ui/features/registration/widgets/gender_selection_radio_group.dart';
import 'package:flix/ui/widgets/form_text_field.dart';
import 'package:flix/ui/widgets/modal/bottom_sheets.dart';
import 'package:flix/ui/widgets/modal/image_picker_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/progress_loader.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  late RegistrationBloc registrationBloc;
  String _avatarUrl = "";
  int selectedGender = 0;

  @override
  Widget build(BuildContext context) {
    registrationBloc = BlocProvider.of<RegistrationBloc>(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(context.loc.sign_up),
        automaticallyImplyLeading: true,
      ),
      body: BlocListener<RegistrationBloc, RegistrationState>(
        bloc: registrationBloc,
        listener: (context, state) {
          if (state is RegistrationErrorState) {
            context.showErrorSnackBar(state.errorType.errorString(context));
          } else if (state is RegistrationSuccess) {
            context.go(RoutesName.home.path);
          }
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    20.verticalSpaceFromWidth,
                    _avatar(context),
                    50.verticalSpaceFromWidth,
                    FormTextField(
                      widgetKey: const Key("name_field"),
                      _nameController,
                      hintText: context.loc.full_name,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.text,
                    ),
                    16.verticalSpaceFromWidth,
                    FormTextField(
                      widgetKey: const Key("email_field"),
                      _emailController,
                      hintText: context.loc.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    15.verticalSpaceFromWidth,
                    _dateField(context),
                    16.verticalSpaceFromWidth,
                    FormTextField(
                      widgetKey: const Key("password_field"),
                      _passwordController,
                      isPassword: true,
                      hintText: context.loc.password,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    3.verticalSpaceFromWidth,
                    Focus(
                      descendantsAreFocusable: false,
                      canRequestFocus: false,
                      child: Text(
                        context.loc.password_config,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey),
                      ),
                    ),
                    16.verticalSpaceFromWidth,
                    FormTextField(
                      widgetKey: const Key("confirm_password_field"),
                      _confirmPasswordController,
                      isPassword: true,
                      hintText: context.loc.confirm_password,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    16.verticalSpaceFromWidth,
                    6.verticalSpaceFromWidth,
                    GenderSelectionRadioGroup(
                      onSelected: (selectedIndex) {
                        selectedGender = selectedIndex;
                      },
                    ),
                    22.verticalSpaceFromWidth,
                    _submitButton(context),
                  ],
                ),
              ),
            ),
            _progressView()
          ],
        ),
      ),
    ));
  }

  _submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        registrationBloc.add(RegistrationSubmitEvent(
            fullName: _nameController.text,
            email: _emailController.text,
            password: _passwordController.text,
            confirmPassword: _confirmPasswordController.text,
            gender: selectedGender,
            avatar: _avatarUrl,
            dob: _dobController.text));
      },
      child: Text(context.loc.sign_up),
    );
  }

  Widget _progressView() {
    return BlocBuilder(
        bloc: registrationBloc,
        builder: (context, state) {
          return Visibility(
            visible: state is RegistrationLoading,
            child: const ProgressLoader(),
          );
        });
  }

  _avatar(BuildContext context) {
    return BlocBuilder(
      bloc: registrationBloc,
      buildWhen: (previous, current) =>
          current is RegistrationProfilePicState ||
          current is RegistrationInitial,
      builder: (context, state) {
        if (state is RegistrationProfilePicState && state.imageUrl.isNotEmpty) {
          _avatarUrl = state.imageUrl;
          return GestureDetector(
            onTap: () => _showImagePicker(context),
            child: CircleAvatar(
              radius: 45,
              backgroundImage: FileImage(File(state.imageUrl)),
            ),
          );
        } else {
          _avatarUrl = "";
          return GestureDetector(
            onTap: () => _showImagePicker(context),
            child: CircleAvatar(
              radius: 45,
              backgroundColor: context.colorScheme.primaryContainer,
              child: const Icon(Icons.person),
            ),
          );
        }
      },
    );
  }

  _showImagePicker(BuildContext context) async {
    String? action = await showModalWithRoundedTopCorner(
        context: context,
        child: ImagePickerModal(showRemoveOption: _avatarUrl.isNotEmpty));
    _handleImageAction(action);
  }

  _handleImageAction(String? action) async {
    if (action == context.loc.remove_image) {
      _imageUrlChanged("");
    } else if (action == context.loc.capture_now) {
      final XFile? photo =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (photo != null) {
        _imageUrlChanged(photo.path);
      }
    } else if (action == context.loc.pick_gallery) {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        _imageUrlChanged(image.path);
      }
    }
  }

  _imageUrlChanged(String url) {
    registrationBloc.add(RegistrationProfilePicEvent(imageUrl: url));
  }

  _dateField(BuildContext context) {
    return TextField(
      key: const Key("dob_field"),
      controller: _dobController,
      readOnly: true,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          hintText: context.loc.dob,
          suffixIcon: const Icon(Icons.calendar_month_rounded)),
      onTap: () => _showPicker(),
    );
  }

  Future<void> _showPicker() async {
    DateTime? dob = await context.showDobPicker();
    if (dob != null) {
      _dobController.text = dob.formatted;
    }
  }
}
