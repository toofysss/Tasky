import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../Helpers/applocalization.dart';
import '../Screens/error.dart';
import '../Widget/custom_back_Button.dart';
import '../Widget/priority.dart';
import '../Widget/progress.dart';
import '../blocs/Task/task_bloc.dart';
import '../constant/asset.dart';
import '../constant/theme.dart';
import 'loading.dart';

class TaskDetails extends StatelessWidget {
  final String iD;
  const TaskDetails({required this.iD, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(context)..add(TaskLoadingData(iD: iD)),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Task_Details".tr(context)),
          leading: const CustomBackButton(),
          actions: [
            //////////////////// More Button ////////////////
            PopupMenuButton<String>(
              splashRadius: 12,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              itemBuilder: (BuildContext context) {
                return [
                  //////////////////// Edit Button ////////////////

                  PopupMenuItem<String>(
                    onTap: () {
                      final taskState = context.read<TaskBloc>().state;
                      if (taskState is TaskLoaded) {
                        context.read<TaskBloc>().add(
                              UpdateTask(
                                image: taskState.taskDetails.image!,
                                desc: taskState.taskDetails.desc!,
                                priority: taskState.priority ??
                                    taskState.taskDetails.priority!,
                                status: taskState.status ??
                                    taskState.taskDetails.status!,
                                title: taskState.taskDetails.title!,
                                user: taskState.taskDetails.user!,
                                iD: taskState.taskDetails.sId!,
                              ),
                            );
                      }
                    },
                    child: Center(
                        child: Text(
                      'Edit'.tr(context),
                      style: GoogleFonts.dmSans(
                          color: ThemeColor.textPrimaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    )),
                  ),
                  const PopupMenuItem<String>(
                    enabled: false,
                    height: 0,
                    padding: EdgeInsets.zero,
                    child: Divider(
                      endIndent: 20,
                      indent: 20,
                    ),
                  ),

                  //////////////////// Delete Button ////////////////
                  PopupMenuItem<String>(
                    onTap: () async => context.read<TaskBloc>().add(
                          RemoveTask(iD: iD),
                        ),
                    child: Center(
                        child: Text(
                      'Delete'.tr(context),
                      style: GoogleFonts.dmSans(
                          color: ThemeColor.popupDeleteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ];
              },
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoaded) {
              return RefreshIndicator(
                onRefresh: () async =>
                    context.read<TaskBloc>()..add(TaskLoadingData(iD: iD)),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          Assets.test,
                          fit: BoxFit.fill,
                          width: 375,
                          height: 225,
                        ),
                      ),
                      Text(
                        state.taskDetails.title ?? "",
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: ThemeColor.textPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        state.taskDetails.desc ?? "",
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: ThemeColor.textPrimaryColor.withOpacity(.6),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        color: ThemeColor.secondaryBackground,
                        child: ListTile(
                          title: Text(
                            "End_Date".tr(context),
                            style: GoogleFonts.dmSans(
                                color: const Color(0xff6E6A7C),
                                fontSize: 9,
                                fontWeight: FontWeight.w400),
                          ),
                          subtitle: Text(
                            state.taskDetails.updatedAt!.split("T").first,
                            style: GoogleFonts.dmSans(
                                color: ThemeColor.textPrimaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          trailing: const Icon(
                            CupertinoIcons.calendar,
                            color: ThemeColor.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Progress(
                        value: state.taskDetails.status,
                        onchanged: (newvalue) {
                          context
                              .read<TaskBloc>()
                              .add(ChangeStatus(status: newvalue!));
                        },
                      ),
                      const SizedBox(height: 10),
                      Priority(
                        value: state.taskDetails.priority,
                        onChanged: (newvalue) {
                          context
                              .read<TaskBloc>()
                              .add(ChangePriority(priority: newvalue!));
                        },
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: QrImageView(
                          data: state.taskDetails.sId ?? "",
                          version: QrVersions.auto,
                          size: 326.0,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is TaskLoading) {
              //////////////////// Loading Page ////////////////
              return const LoadingPage();
            } else {
              //////////////////// Error Page ////////////////
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<TaskBloc>().add(RefreshTokenEvent());
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
