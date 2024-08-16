import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import '../blocs/Logout/logout_bloc.dart';

import '../Widget/card.dart';
import '../../Helpers/applocalization.dart';
import '../../Screens/empty.dart';
import '../blocs/HomePage/home_bloc.dart';
import '../constant/routes.dart';
import '../constant/theme.dart';
import 'error.dart';
import 'loading.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ScrollController _scrollController = ScrollController();

  void _setupScrollController(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<HomeBloc>().add(LoadHomeData());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _setupScrollController(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //////////////////// Qr Scanner ////////////////

          if (Platform.isAndroid || Platform.isIOS)
            IconButton(
              style: const ButtonStyle(
                  minimumSize: WidgetStatePropertyAll(Size(50, 50)),
                  backgroundColor:
                      WidgetStatePropertyAll(ThemeColor.secondaryBackground)),
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRouting.qrScan),
              icon: const Icon(
                HugeIcons.strokeRoundedQrCode,
                color: ThemeColor.primaryColor,
              ),
            ),
          const SizedBox(height: 5),
          //////////////////// New Task Button ////////////////
          IconButton(
              style: const ButtonStyle(
                  minimumSize: WidgetStatePropertyAll(Size(64, 64)),
                  backgroundColor:
                      WidgetStatePropertyAll(ThemeColor.primaryColor)),
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRouting.newTask),
              icon: const Icon(
                Icons.add,
                color: ThemeColor.tabBackgroundColor,
                size: 40,
              )),
        ],
      ),
      //////////////////// Logo ////////////////
      appBar: AppBar(
        title: Text(
          "Logo",
          style: GoogleFonts.dmSans(
              fontSize: 24,
              color: ThemeColor.textPrimaryColor,
              fontWeight: FontWeight.w700),
        ),
        actions: [
          //////////////////// Refresh Button ////////////////
          if (Platform.isWindows)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: IconButton(
                onPressed: () async =>
                    context.read<HomeBloc>().add(LoadHomeData()),
                icon: const Icon(HugeIcons.strokeRoundedArrowReloadVertical),
              ),
            ),

          //////////////////// Profile Button ////////////////
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              onPressed: () => Navigator.pushNamed(context, AppRouting.profile),
              icon: const Icon(HugeIcons.strokeRoundedUserCircle),
            ),
          ),
          //////////////////// Logout Button ////////////////

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              onPressed: () {
                context.read<LogoutBloc>().add(Logout());
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: ThemeColor.primaryColor,
              ),
            ),
          )
        ],
      ),
      body: BlocListener<LogoutBloc, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Navigator.of(context).pushReplacementNamed(AppRouting.login);
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoaded) {
              if (state.allTasks.isEmpty) {
                //////////////////// Empty Page ////////////////
                return const EmptyPage();
              }

              return RefreshIndicator(
                onRefresh: () async =>
                    context.read<HomeBloc>()..add(LoadHomeData()),
                child: DefaultTabController(
                  length: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //////////////////// Title ////////////////
                        Text(
                          "MyTask".tr(context),
                          style: GoogleFonts.dmSans(
                              fontSize: 16,
                              color:
                                  ThemeColor.textPrimaryColor.withOpacity(.6),
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 10),

                        //////////////////// Tabs ////////////////
                        SizedBox(
                          height: 60,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              bool isSelected = state.selectedTabIndex == index;

                              return TextButton(
                                style: const ButtonStyle(
                                    padding: WidgetStatePropertyAll(
                                        EdgeInsets.symmetric(horizontal: 5)),
                                    overlayColor: WidgetStatePropertyAll(
                                        Colors.transparent)),
                                onPressed: () => context
                                    .read<HomeBloc>()
                                    .add(FilterTasksByTab(index)),
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  height: 36,
                                  alignment: Alignment.topCenter,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? ThemeColor.primaryColor
                                        : ThemeColor.secondaryBackground,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Text(
                                    "Tab$index".tr(context),
                                    style: GoogleFonts.dmSans(
                                        fontWeight: isSelected
                                            ? FontWeight.w700
                                            : FontWeight.w400,
                                        fontSize: 16,
                                        color: isSelected
                                            ? ThemeColor.tabBackgroundColor
                                            : ThemeColor.tabUnselectedColor),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        //////////////////// Tasks ////////////////
                        Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: state.filteredTasks.length,
                            itemBuilder: (context, index) {
                              final task = state.filteredTasks[index];
                              return TaskCard(data: task);
                            },
                          ),
                        ),
                        if (state.isLoadingMore)
                          Container(
                            color: Colors.transparent,
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: const Center(
                                child: CircularProgressIndicator()),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is HomeLoading) {
              //////////////////// Loading Page ////////////////
              return const LoadingPage();
            } else {
              //////////////////// Error Page ////////////////
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<HomeBloc>().add(RefreshTokenEvent());
                },
                child: const ErrorPage(),
              );
            }
          },
        ),
      ),
    );
  }
}
