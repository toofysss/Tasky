import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Helpers/applocalization.dart';
import '../blocs/Profile/profile_bloc.dart';
import '../Widget/custom_back_Button.dart';
import '../constant/theme.dart';
import 'error.dart';
import 'loading.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileBloc()..add(LoadProfileData()),
        child: Scaffold(
          appBar: AppBar(
              title: const Text("Profile"), leading: const CustomBackButton()),
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoaded) {
                return RefreshIndicator(
                  edgeOffset: 20,
                  onRefresh: () async {
                    context.read<ProfileBloc>().add(LoadProfileData());
                  },
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      children: [
                        //////////////////// Name ////////////////
                        ListTile(
                          selected: true,
                          title: Text(
                            "Name".tr(context).toUpperCase(),
                            style: GoogleFonts.dmSans(
                                color: ThemeColor.profileTextColor.withOpacity(.4),
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                          subtitle: Text(
                            state.profileData.displayName!,
                            style: GoogleFonts.dmSans(
                                color: ThemeColor.profileTextColor.withOpacity(.6),
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 15),

                        //////////////////// Phone ////////////////
                        ListTile(
                          selected: true,
                          title: Text(
                            "Phone".tr(context).toUpperCase(),
                            style: GoogleFonts.dmSans(
                                color: ThemeColor.profileTextColor.withOpacity(.4),
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                          subtitle: Text(
                            state.profileData.username!,
                            style: GoogleFonts.dmSans(
                                color: ThemeColor.profileTextColor.withOpacity(.6),
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.copy_rounded,
                                color: ThemeColor.primaryColor,
                              )),
                        ),
                        const SizedBox(height: 15),

                        //////////////////// Level ////////////////
                        ListTile(
                          selected: true,
                          title: Text(
                            "Level".tr(context).toUpperCase(),
                            style: GoogleFonts.dmSans(
                                color: ThemeColor.profileTextColor.withOpacity(.4),
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                          subtitle: Text(
                            state.profileData.level!,
                            style: GoogleFonts.dmSans(
                                color: ThemeColor.profileTextColor.withOpacity(.6),
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 15),

                        //////////////////// Years Experience ////////////////
                        ListTile(
                          selected: true,
                          title: Text(
                            "Yearsexperience".tr(context).toUpperCase(),
                            style: GoogleFonts.dmSans(
                                color: ThemeColor.profileTextColor.withOpacity(.4),
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                          subtitle: Text(
                            state.profileData.experienceYears.toString(),
                            style: GoogleFonts.dmSans(
                                color: ThemeColor.profileTextColor.withOpacity(.6),
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 15),

                        //////////////////// Location ////////////////
                        ListTile(
                          selected: true,
                          title: Text(
                            "Location".tr(context).toUpperCase(),
                            style: GoogleFonts.dmSans(
                                color: ThemeColor.profileTextColor.withOpacity(.4),
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                          subtitle: Text(
                            state.profileData.address!,
                            style: GoogleFonts.dmSans(
                                color: ThemeColor.profileTextColor.withOpacity(.6),
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else if (state is ProfileLoadingState) {
                //////////////////// Loading Page ////////////////
                return const LoadingPage();
              } else {
                //////////////////// Error Page ////////////////
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<ProfileBloc>().add(RefreshToken());
                  },
                  child: const ErrorPage(),
                );
              }
            },
          ),
        ));
  }
}
