import 'package:degrees_runners/custom_widgets/loader/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/app_colors.dart';
import '../../../core/constants/strings.dart';
import '../../../custom_widgets/appbar/custom_appbar_with_center_title.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/custom_textfield.dart';
import 'edit_profile_provider.dart';
import 'widgets/edit_icon_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EditProfileProvider>().getUserDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EditProfileProvider>(context, listen: false);

    return Scaffold(
      appBar: const CustomAppbarWithCenterTitle(
        title: 'Edit Profile',
      ),
      body: Consumer<EditProfileProvider>(
        builder: (context, _, child) => provider.isLoadingProfile
            ? const Center(
                child: CustomLoader(
                  bgColor: AppColors.black,
                ),
              )
            : Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 120.h,
                                width: 120.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.black,
                                    width: 2.w,
                                  ),
                                ),
                                child: ClipOval(
                                  //* Profile image
                                  child: Consumer<EditProfileProvider>(
                                    builder: (context, provider, child) {
                                      return CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        radius: 50,
                                        backgroundImage:
                                            provider.getProfileImage(),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    provider.pickImage();
                                  },
                                  child: const EditIconWidget(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          CustomTextField(
                            hint: 'Anup Parekh',
                            prefixIcon: IconStrings.person,
                            iconColor: AppColors.black,
                            controller: provider.userNameController,
                            suffixWidget: Padding(
                              padding: EdgeInsets.all(9.w),
                              child: const EditIconWidget(),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          CustomTextField(
                            hint: 'E-1102, 11th Floor, Titanium City C',
                            prefixIcon: IconStrings.locationWhite,
                            iconColor: AppColors.black,
                            controller: provider.addressController,
                            suffixWidget: Padding(
                              padding: EdgeInsets.all(9.w),
                              child: const EditIconWidget(),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          CustomTextField(
                            hint: '+91 12345 67890',
                            prefixIcon: IconStrings.phone,
                            iconColor: AppColors.black,
                            controller: provider.mobileController,
                            suffixWidget: Padding(
                              padding: EdgeInsets.all(9.w),
                              child: const EditIconWidget(),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          CustomTextField(
                            hint: 'email@example.com',
                            prefixIcon: IconStrings.email,
                            iconColor: AppColors.black,
                            controller: provider.emailController,
                            suffixWidget: Padding(
                              padding: EdgeInsets.all(9.w),
                              child: const EditIconWidget(),
                            ),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 48.h,
                    left: 32.w,
                    right: 32.w,
                    child: CustomButton(
                      height: 55.h,
                      onTap: () {
                        context
                            .read<EditProfileProvider>()
                            .editProfile(context);
                      },
                      text: 'done',
                      textColor: AppColors.seaShell,
                      bgColor: AppColors.black,
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
