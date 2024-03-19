import 'dart:io';

import 'package:flix/core/extension/build_context_ext.dart';
import 'package:flix/core/extension/color_extension.dart';
import 'package:flix/core/extension/date_time_extension.dart';
import 'package:flix/ui/features/account/bloc/account_bloc.dart';
import 'package:flix/ui/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/form_text_field.dart';
import '../../widgets/modal/bottom_sheets.dart';
import '../../widgets/modal/image_picker_modal.dart';
import '../registration/widgets/gender_selection_radio_group.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  User? user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer(
      bloc: BlocProvider.of<AccountBloc>(context)..add(LoadProfile()),
      builder: (context, state) => BlocBuilder(
        bloc: BlocProvider.of<AccountBloc>(context),
        builder: (BuildContext context, state) {
          if(user!=null){
            return _profileView(user!);
          }
          return const SizedBox.expand();
        },
      ),
      listener: (BuildContext context, AccountState state) {
        if (state is ProfileUpdated) {
          context.showSuccessSnackBar(context.loc.profile_updated);
        } else if (state is ProfilePicChangedState) {
          user?.avatar = state.imageUrl;
        } else if (state is ProfileLoaded) {
          user = state.user;
        }
      },
    ));
  }

  Widget _profileView(User userModel) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            20.verticalSpaceFromWidth,
            _avatar(context, userModel),
            50.verticalSpaceFromWidth,
            FormTextField(
              _nameController..text = userModel.fullName,
              hintText: context.loc.full_name,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.text,
            ),
            16.verticalSpaceFromWidth,
            FormTextField(
              _emailController..text = userModel.email,
              hintText: context.loc.email,
              keyboardType: TextInputType.emailAddress,
              isEnabled: false,
            ),
            15.verticalSpaceFromWidth,
            _dateField(userModel),
            16.verticalSpaceFromWidth,
            6.verticalSpaceFromWidth,
            GenderSelectionRadioGroup(
              selectedIndex: userModel.gender,
              onSelected: (selectedIndex) {
                userModel.gender = selectedIndex;
              },
            ),
            22.verticalSpaceFromWidth,
            _submitButton(context, userModel),
          ],
        ),
      ),
    );
  }

  _submitButton(BuildContext context, User userModel) {
    return ElevatedButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        BlocProvider.of<AccountBloc>(context).add(ProfileUpdateSubmitEvent(
            id: userModel.id!,
            fullName: _nameController.text,
            email: _emailController.text,
            gender: userModel.gender,
            password: userModel.password,
            avatar: userModel.avatar,
            dob: _dobController.text));
      },
      child: Text(context.loc.update_profile),
    );
  }

  _dateField(User userModel) {
    return TextField(
      controller: _dobController..text = userModel.dob,
      readOnly: true,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          hintText: context.loc.dob,
          suffixIcon: const Icon(Icons.calendar_month_rounded)),
      onTap: () => _showDatePicker(),
    );
  }

  Future<void> _showDatePicker() async {
    DateTime? dob = await context.showDobPicker();
    if (dob != null) {
      _dobController.text = dob.formatted;
    }
  }

  _avatar(BuildContext context, User user) {
    if (user.avatar.isNotEmpty) {
      return GestureDetector(
        onTap: () => _showImagePicker(context, true),
        child: CircleAvatar(
          radius: 45,
          backgroundImage: FileImage(File(user.avatar)),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => _showImagePicker(context, false),
        child: CircleAvatar(
          radius: 45,
          backgroundColor: context.colorScheme.primaryContainer,
          child: Icon(
              user.gender == 0 ? Icons.male_rounded : Icons.female_rounded),
        ),
      );
    }
  }

  _showImagePicker(BuildContext context, bool showRemove) async {
    String? action = await showModalWithRoundedTopCorner(
        context: context,
        child: ImagePickerModal(showRemoveOption: showRemove));
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
    BlocProvider.of<AccountBloc>(context)
        .add(ProfilePicChangeEvent(imageUrl: url));
  }
}
