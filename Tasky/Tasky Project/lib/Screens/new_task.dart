import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:dotted_border/dotted_border.dart';

import '../Helpers/applocalization.dart';
import '../Widget/priority.dart';
import '../Widget/customtextfield.dart';
import '../constant/theme.dart';
import '../Widget/custom_back_Button.dart';
import '../blocs/Task/task_bloc.dart';

class NewTask extends StatelessWidget {
  const NewTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: const Text("Add new task"),
        leading: const CustomBackButton(),
      ),
      body: BlocProvider(
        create: (context) => TaskBloc(context),
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Form(
                key: state.formKey,
                child: Column(
                  children: [
                    //////////////////// Add Image ////////////////
                    GestureDetector(
                      onTap: () => context.read<TaskBloc>()
                        ..add(
                          UploadImage(),
                        ),
                      child: DottedBorder(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        color: ThemeColor.primaryColor,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              HugeIcons.strokeRoundedImageAdd01,
                              color: ThemeColor.primaryColor,
                              size: 24.0,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Add_Img'.tr(context),
                              style: const TextStyle(
                                fontSize: 19,
                                color: ThemeColor.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    //////////////////// Title Of Task ////////////////
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Title_Task".tr(context),
                        style: GoogleFonts.dmSans(
                            fontSize: 12,
                            color: ThemeColor.textSecondaryColor,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    CustomTextField(
                      controller: state.title,
                      hint: "TitleTask".tr(context),
                    ),
                    const SizedBox(height: 10),

                    //////////////////// Description Of Task ////////////////

                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Title_Description".tr(context),
                        style: GoogleFonts.dmSans(
                            fontSize: 12,
                            color: ThemeColor.textSecondaryColor,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    CustomTextField(
                      validate: true,
                      controller: state.dscrp,
                      maxline: 10,
                      hint: "TitleDescription".tr(context),
                    ),
                    const SizedBox(height: 10),

                    //////////////////// Priority Of Task ////////////////

                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Priority".tr(context),
                        style: GoogleFonts.dmSans(
                            fontSize: 12,
                            color: ThemeColor.textSecondaryColor,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Priority(
                      value: state.priority,
                      onChanged: (newvalue) {
                        context.read<TaskBloc>().add(
                              ChangePriority(priority: newvalue!),
                            );
                      },
                    ),
                    const SizedBox(height: 10),

                    //////////////////// Date Of Task ////////////////
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Date".tr(context),
                        style: GoogleFonts.dmSans(
                            fontSize: 12,
                            color: ThemeColor.textSecondaryColor,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    CustomTextField(
                      validate: true,
                      controller: state.date,
                      readonly: true,
                      suffix: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: IconButton(
                            onPressed: () {
                              context.read<TaskBloc>().add(ChangeDate());
                            },
                            icon: const Icon(
                              CupertinoIcons.calendar,
                              color: ThemeColor.primaryColor,
                            )),
                      ),
                      hint: "Choose_Date".tr(context),
                    ),
                    const SizedBox(height: 20),

                    //////////////////// Button Of Task ////////////////
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 49,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<TaskBloc>().add(
                                UploadTask(
                                    desc: state.dscrp.text,
                                    priority: state.priority!,
                                    dueDate: state.date.text,
                                    title: state.title.text),
                              );
                        },
                        iconAlignment: IconAlignment.end,
                        child: state.isLoading
                            ? const CircularProgressIndicator(
                                color: ThemeColor.loadingIndicatorColor)
                            : Text("Add_task".tr(context),
                                style: Theme.of(context)
                                    .elevatedButtonTheme
                                    .style
                                    ?.textStyle
                                    ?.resolve({})),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
