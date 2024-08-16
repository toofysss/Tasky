import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import '../Helpers/applocalization.dart';
import '../Models/homemodel.dart';
import '../blocs/Task/task_bloc.dart';
import '../constant/asset.dart';
import '../constant/routes.dart';
import '../constant/theme.dart';

class TaskCard extends StatelessWidget {
  final HomeModel data;

  const TaskCard({super.key, required this.data});

  Color _getPriorityTextColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'High':
        return ThemeColor.highPriorityColor;
      case 'Medium':
        return ThemeColor.mediumPriorityColor;
      default:
        return ThemeColor.lowPriorityColor;
    }
  }

  Color _getStatusBackgroundColor(String status) {
    switch (status.toLowerCase()) {
      case 'in progress':
        return ThemeColor.inProgressStatusBackground;
      case 'waiting':
        return ThemeColor.waitingStatusBackground;
      default:
        return ThemeColor.finishedStatusBackground;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'in progress':
        return ThemeColor.inProgressStatusColor;
      case 'waiting':
        return ThemeColor.waitingStatusColor;
      default:
        return ThemeColor.finishedStatusColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        AppRouting.taskDetails,
        arguments: {'iD': data.sId},
      ),
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              //////////////////// Image ////////////////

              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(64.37),
                    image: const DecorationImage(
                        image: AssetImage(Assets.test), fit: BoxFit.fill)),
              ),
              const SizedBox(width: 10),

              //////////////////// Title + Progress ////////////////
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //////////////////// Title  ////////////////
                        Expanded(
                          child: Text(
                            data.title ?? "",
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: ThemeColor.textPrimaryColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 10),
                        //////////////////// Progress ////////////////
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: _getStatusBackgroundColor(data.status ?? ""),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            data.status ?? "",
                            maxLines: 1,
                            style: TextStyle(
                              color: _getStatusTextColor(data.status ?? ""),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),

                    //////////////////// Description ////////////////
                    Text(
                      data.desc ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: ThemeColor.textPrimaryColor.withOpacity(.6),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //////////////////// Priority ////////////////
                        Row(
                          children: [
                            Icon(
                              HugeIcons.strokeRoundedFlag02,
                              color: _getPriorityTextColor(data.priority ?? ""),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              data.priority ?? "",
                              style: GoogleFonts.dmSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color:
                                    _getPriorityTextColor(data.priority ?? ""),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        //////////////////// Date ////////////////
                        Flexible(
                          child: Text(
                            data.updatedAt!.split('T').first,
                            maxLines: 1,
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: const Color(0xff24252C).withOpacity(.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //////////////////// More Button ////////////////
              PopupMenuButton<String>(
                splashRadius: 12,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                itemBuilder: (BuildContext context) {
                  return [
                    //////////////////// Edit Button ////////////////

                    PopupMenuItem<String>(
                      onTap: () => context.read<TaskBloc>().add(
                            UpdateTask(
                                image: data.image!,
                                desc: data.desc!,
                                priority: data.priority!,
                                status: data.status!,
                                title: data.title!,
                                user: data.user!,
                                iD: data.sId!),
                          ),
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
                            RemoveTask(iD: data.sId!),
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
        ),
      ),
    );
  }
}
