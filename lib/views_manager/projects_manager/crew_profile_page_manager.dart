import 'package:beehive/constants/api_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/model/crew_on_this_project_response.dart';
import 'package:beehive/provider/add_note_page_manager_provider.dart';
import 'package:beehive/provider/crew_profile_page_provider_manager.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/views_manager/projects_manager/show_private_note_manager.dart';
import 'package:beehive/widget/custom_circular_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color_constants.dart';
import '../../constants/dimension_constants.dart';
import '../../constants/image_constants.dart';
import '../../constants/route_constants.dart';
import '../../helper/dialog_helper.dart';
import '../../model/timesheet_crew_details.dart';
import '../../widget/image_view.dart';
import 'add_note_page_manager.dart';

class CrewProfilePageManager extends StatelessWidget {
  CrewProfilePageManager({Key? key, required this.crewId}) : super(key: key);

  final String? crewId;

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<CrewProfilePageProviderManager>(onModelReady: (provider) {
      provider.getCrewDetails(context, crewId!);
    }, builder: (context, provider, _) {
      return Scaffold(
        key: _scaffoldkey,
        appBar: CommonWidgets.appBarWithTitleAndAction(context,
            title: "crew_profile",
            actionButtonRequired: false, popFunction: () {
          CommonWidgets.hideKeyboard(context);
          Navigator.pop(context);
        }),
        body: provider.state == ViewState.busy
            ? const Center(
                child: CircularProgressIndicator(
                  color: ColorConstants.primaryGradient2Color,
                ),
              )
            : Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      crewProfileWidget(context, provider),
                      SizedBox(
                        height: DimensionConstants.d16.h,
                      ),
                      profileDetails(context, provider),
                      SizedBox(
                        height: DimensionConstants.d40.h,
                      ),
                      Text("projects".tr()).boldText(
                          context, DimensionConstants.d20.sp, TextAlign.left,
                          color: ColorConstants.colorBlack),
                      SizedBox(
                        height: DimensionConstants.d16.h,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider
                                .crewDetails!.data![0].crewProjects?.length ??
                            0,
                        itemBuilder: (context, index) =>
                            projectNameWidget(context, index, provider),
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: DimensionConstants.d8.h,
                          );
                        },
                      ),
                      SizedBox(
                        height: DimensionConstants.d32.h,
                      ),
                      Text("certifications".tr()).boldText(
                          context, DimensionConstants.d20.sp, TextAlign.left,
                          color: ColorConstants.colorBlack),
                      SizedBox(
                        height: DimensionConstants.d16.h,
                      ),
                      provider.crewDetails!.data![0].certs!.isEmpty
                          ? Container()
                          : scaleNotesWidget(context, provider),
                      SizedBox(
                        height: DimensionConstants.d32.h,
                      ),
                      addPrivateNote(context, provider),
                      provider.crewDetails!.data![0].pvtNotes!.isEmpty
                          ? Container()
                          : Column(
                              children: [
                                SizedBox(
                                  height: DimensionConstants.d25.h,
                                ),
                                notesList(
                                  context,
                                  provider.crewDetails!.data![0].pvtNotes!,
                                ),
                              ],
                            ),
                      SizedBox(
                        height: DimensionConstants.d53.h,
                      ),
                    ],
                  ),
                ),
              ),
      );
    });
  }

  Widget crewProfileWidget(
      BuildContext context, CrewProfilePageProviderManager provider) {
    return Container(
      height: DimensionConstants.d192.h,
      decoration: BoxDecoration(
          color: ColorConstants.colorWhite,
          border: Border(
            bottom: BorderSide(
                color: ColorConstants.littleDarkGray,
                width: DimensionConstants.d1.w),
          )),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: DimensionConstants.d25.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              (provider.crewDetails!.data![0].profileImage == null)
                  ? ClipRRect(
                      borderRadius:
                          BorderRadius.circular(DimensionConstants.d50.r),
                      child: SizedBox(
                        height: DimensionConstants.d93.w,
                        width: DimensionConstants.d93.w,
                        child: const ImageView(
                            path: ImageConstants.emptyImageIcon),
                      ),
                    )
                  : ClipRRect(
                      borderRadius:
                          BorderRadius.circular(DimensionConstants.d50.r),
                      child: SizedBox(
                        height: DimensionConstants.d93.w,
                        width: DimensionConstants.d93.w,
                        child: ImageView(
                          path: (ApiConstantsCrew.BASE_URL_IMAGE +
                              provider.crewDetails!.data![0].profileImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              SizedBox(
                width: DimensionConstants.d14.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: DimensionConstants.d150.w,
                    child: Text(provider.crewDetails!.data![0].name ?? "")
                        .semiBoldText(
                            context, DimensionConstants.d22.sp, TextAlign.left,
                            color: ColorConstants.deepBlue,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                  ),
                  SizedBox(
                    height: DimensionConstants.d7.h,
                  ),
                  SizedBox(
                    width: DimensionConstants.d150.w,
                    child: Text(provider.crewDetails!.data![0].position ?? "")
                        .boldText(
                            context, DimensionConstants.d18.sp, TextAlign.left,
                            color: ColorConstants.deepBlue,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                  ),
                  SizedBox(
                    height: DimensionConstants.d8.h,
                  ),
                  SizedBox(
                    width: DimensionConstants.d150.w,
                    child: Text(provider.crewDetails!.data![0].speciality ?? "")
                        .regularText(
                            context, DimensionConstants.d14.sp, TextAlign.left,
                            color: ColorConstants.deepBlue,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: DimensionConstants.d16.h,
          ),
          provider.priceUpdateLoader
              ? const Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.primaryGradient2Color,
                  ),
                )
              : crewRateWidget(context, provider),
        ],
      ),
    );
  }

  Widget crewRateWidget(
      BuildContext context, CrewProfilePageProviderManager provider) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => DialogHelper.editRateDialogBox(
                  context,
                  projectRate: provider.crewDetails!.data![0].projectRate ?? '',
                )).then((value) {
          if (value != null && value.isNotEmpty) {
            provider.updateCrewRate(
                context, provider.crewDetails!.data![0].id, value);
          }
        });
      },
      child: Container(
        height: DimensionConstants.d42.h,
        width: DimensionConstants.d128.w,
        decoration: BoxDecoration(
          border: Border.all(
              color: ColorConstants.grayD2D2D7, width: DimensionConstants.d1.w),
          borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: DimensionConstants.d14.w),
          child: Row(
            children: <Widget>[
              const Text("\$").semiBoldText(
                  context, DimensionConstants.d14.sp, TextAlign.left,
                  color: ColorConstants.colorBlack),
              Text(provider.crewDetails!.data![0].projectRate ?? "")
                  .semiBoldText(
                      context, DimensionConstants.d14.sp, TextAlign.left,
                      color: ColorConstants.colorBlack),
              const Text("/hr").semiBoldText(
                  context, DimensionConstants.d14.sp, TextAlign.left,
                  color: ColorConstants.colorBlack),
              SizedBox(
                width: DimensionConstants.d3.w,
              ),
              const ImageView(
                path: ImageConstants.penIcon,
                color: ColorConstants.colorBlack,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileDetails(
      BuildContext context, CrewProfilePageProviderManager provider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d8.w),
      child: Column(
        children: <Widget>[
          (provider.crewDetails!.data![0].company == null ||
                  provider.crewDetails!.data![0].company == "")
              ? Container()
              : SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      ImageView(
                        path: ImageConstants.companyIcon,
                        height: DimensionConstants.d24.h,
                        width: DimensionConstants.d24.w,
                        color: ColorConstants.colorBlack,
                      ),
                      SizedBox(
                        width: DimensionConstants.d16.w,
                      ),
                      Expanded(
                          child:
                              Text(provider.crewDetails!.data![0].company ?? "")
                                  .regularText(
                        context,
                        DimensionConstants.d14.sp,
                        TextAlign.left,
                      )),
                    ],
                  ),
                ),
          (provider.crewDetails!.data![0].company == null ||
                      provider.crewDetails!.data![0].company == "") ==
                  null
              ? Container()
              : SizedBox(
                  height: DimensionConstants.d30.h,
                ),
          provider.crewDetails!.data![0].phoneNumber == null
              ? Container()
              : SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      ImageView(
                        path: ImageConstants.callerIcon,
                        height: DimensionConstants.d24.h,
                        width: DimensionConstants.d24.w,
                        color: ColorConstants.colorBlack,
                      ),
                      SizedBox(
                        width: DimensionConstants.d16.w,
                      ),
                      Expanded(
                        child: Text(provider.crewDetails!.data![0].phoneNumber
                                .toString())
                            .regularText(
                          context,
                          DimensionConstants.d14.sp,
                          TextAlign.left,
                        ),
                      )
                    ],
                  ),
                ),
          provider.crewDetails!.data![0].phoneNumber == null
              ? Container()
              : SizedBox(
                  height: DimensionConstants.d30.h,
                ),
          provider.crewDetails!.data![0].email == null
              ? Container()
              : SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      ImageView(
                        path: ImageConstants.mailerIcon,
                        height: DimensionConstants.d24.h,
                        width: DimensionConstants.d24.w,
                        color: ColorConstants.colorBlack,
                      ),
                      SizedBox(
                        width: DimensionConstants.d16.w,
                      ),
                      Expanded(
                        child: Text(provider.crewDetails!.data![0].email ?? "")
                            .regularText(
                          context,
                          DimensionConstants.d14.sp,
                          TextAlign.left,
                        ),
                      )
                    ],
                  ),
                ),
          (provider.crewDetails!.data![0].address == null ||
                  provider.crewDetails!.data![0].address == "")
              ? Container()
              : SizedBox(
                  height: DimensionConstants.d30.h,
                ),
          (provider.crewDetails!.data![0].address == null ||
                  provider.crewDetails!.data![0].address == "")
              ? Container()
              : SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      ImageView(
                        path: ImageConstants.locationIcon,
                        height: DimensionConstants.d24.h,
                        width: DimensionConstants.d24.w,
                        color: ColorConstants.colorBlack,
                      ),
                      SizedBox(
                        width: DimensionConstants.d16.w,
                      ),
                      Expanded(
                          child:
                              Text(provider.crewDetails!.data![0].address ?? "")
                                  .regularText(
                        context,
                        DimensionConstants.d14.sp,
                        TextAlign.left,
                      )),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget projectNameWidget(BuildContext context, int index,
      CrewProfilePageProviderManager provider) {
    return Row(
      children: <Widget>[
        Container(
          height: DimensionConstants.d40.h,
          width: DimensionConstants.d40.w,
          decoration: BoxDecoration(
            color: provider.crewDetails!.data![0].crewProjects![index].color ==
                    null
                ? Colors.black
                : Color(int.parse(
                    "0x${provider.crewDetails!.data![0].crewProjects![index].color}")),
            borderRadius: BorderRadius.circular(DimensionConstants.d20.r),
          ),
          child: Center(
            child: Text(provider
                    .crewDetails!.data![0].crewProjects![index].projectName
                    .toString()
                    .substring(0, 2)
                    .toUpperCase())
                .boldText(context, DimensionConstants.d16.sp, TextAlign.center,
                    color: ColorConstants.colorWhite),
          ),
        ),
        SizedBox(
          width: DimensionConstants.d10.w,
        ),
        Expanded(
            child: Text(provider.crewDetails!.data![0].crewProjects![index]
                        .projectName ??
                    '')
                .boldText(context, DimensionConstants.d16.sp, TextAlign.left,
                    color: ColorConstants.colorBlack,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis)),
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    DialogHelper.removeProjectDialog(
                      context,
                      cancel: () {
                        Navigator.of(context).pop();
                      },
                      delete: () {
                        Navigator.of(context).pop();
                        provider.removingCrewOnThisProject(
                            _scaffoldkey.currentContext!,
                            provider.crewDetails!.data![0].id!,
                            provider.crewDetails!.data![0].crewProjects![index]
                                    .id ??
                                '');
                      },
                    ));
          },
          child: Text("remove".tr()).boldText(
              context, DimensionConstants.d16.sp, TextAlign.left,
              color: ColorConstants.redColorEB5757),
        )
      ],
    );
  }

  Widget scaleNotesWidget(
      BuildContext context, CrewProfilePageProviderManager provider) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.colorWhite,
          borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
        ),
        child: ListView.builder(
          itemCount: provider.crewDetails!.data![0].certs?.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: DimensionConstants.d25.h,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.pushNamed(
                        context, RouteConstants.showCertificationManagerPage,
                        arguments:
                            provider.crewDetails!.data![0].certs![index]);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: DimensionConstants.d16.w),
                    child: Row(
                      children: <Widget>[
                        Text(provider
                                .crewDetails!.data![0].certs![index].certName
                                .toString())
                            .regularText(context, DimensionConstants.d14.sp,
                                TextAlign.left,
                                color: ColorConstants.colorBlack),
                        Expanded(child: Container()),
                        ImageView(
                          path: ImageConstants.arrowIcon,
                          height: DimensionConstants.d10.h,
                          width: DimensionConstants.d8.w,
                          color: ColorConstants.colorBlack,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: DimensionConstants.d20.h,
                ),
                Container(
                  height: DimensionConstants.d1.h,
                  color: ColorConstants.grayF1F1F1,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget addPrivateNote(BuildContext context,
      CrewProfilePageProviderManager pageProviderManager) {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("private_notes".tr()).boldText(
                context, DimensionConstants.d20.sp, TextAlign.left,
                color: ColorConstants.colorBlack),
            Text("only_you_can_see_these_notes".tr()).regularText(
                context, DimensionConstants.d14.sp, TextAlign.left,
                color: ColorConstants.colorBlack),
          ],
        ),
        Expanded(child: Container()),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteConstants.addNotePageManager,
                    arguments: AddNotePageManager(
                        isPrivate: true,
                        projectId: '',
                        crewId: pageProviderManager.crewDetails?.data![0].id))
                .then((dynamic value) {
              PvtNoteData pvtNoteData = PvtNoteData();
              pvtNoteData = value;
              pageProviderManager.crewDetails!.data![0].pvtNotes?.add(
                  PvtNote(title: pvtNoteData.title, note: pvtNoteData.note));
              pageProviderManager.updateLoadingStatus(true);
            });
          },
          child: Container(
            height: DimensionConstants.d40.h,
            width: DimensionConstants.d113,
            decoration: BoxDecoration(
              color: ColorConstants.deepBlue,
              borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
            ),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: DimensionConstants.d12.w),
              child: Row(
                children: <Widget>[
                  ImageView(
                    path: ImageConstants.addNotesIcon,
                    height: DimensionConstants.d16.h,
                    width: DimensionConstants.d16.w,
                  ),
                  SizedBox(
                    width: DimensionConstants.d7.w,
                  ),
                  Text("add_note".tr()).semiBoldText(
                      context, DimensionConstants.d14.sp, TextAlign.left,
                      color: ColorConstants.colorWhite),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget notesList(BuildContext context, List<PvtNote> notes) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
      child: ListView.builder(
        itemCount: notes.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        //  physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.pushNamed(
                  context, RouteConstants.showPrivateNoteManager,
                  arguments: ShowPrivateNoteManager(
                      title: notes[index].title.toString(),
                      note: notes[index].note.toString()));
            },
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: DimensionConstants.d25.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: DimensionConstants.d16.w),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(notes[index].title ?? "").regularText(
                              context,
                              DimensionConstants.d14.sp,
                              TextAlign.left,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? ColorConstants.colorWhite
                                  : ColorConstants.colorBlack,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis)),
                      ImageView(
                        path: ImageConstants.arrowIcon,
                        height: DimensionConstants.d10.h,
                        width: DimensionConstants.d8.w,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorWhite
                            : ColorConstants.colorBlack,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: DimensionConstants.d20.h,
                ),
                Container(
                  height: DimensionConstants.d1.h,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.grayF1F1F1,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
