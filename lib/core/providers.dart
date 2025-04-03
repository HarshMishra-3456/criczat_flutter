import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';
import 'package:tempalteflutter/modules/contests/views/provider/getcontestbymatchprovider.dart';
import 'package:tempalteflutter/modules/contests/views/provider/getjoinedcontestprovider.dart';
import 'package:tempalteflutter/modules/contests/views/provider/getteambymatchidprovider.dart';
import 'package:tempalteflutter/modules/createTeam/views/provider/getplayerdetailsprovider.dart';
import 'package:tempalteflutter/modules/createTeam/views/provider/selectplayerprovider.dart';
import 'package:tempalteflutter/modules/drawer/views/provider/getoffersprovider.dart';
import 'package:tempalteflutter/modules/home/views/provider/getbannerprovider.dart';
import 'package:tempalteflutter/modules/home/views/provider/getlivematchesprovider.dart';
import 'package:tempalteflutter/modules/home/views/provider/getupcomingmatchprovider.dart';
import 'package:tempalteflutter/modules/home/views/provider/playing11provider.dart';
import 'package:tempalteflutter/modules/myProfile/views/provider/getalltrasactionprovider.dart';
import 'package:tempalteflutter/modules/myProfile/views/provider/getusernotificationprovider.dart';
import 'package:tempalteflutter/modules/myProfile/views/provider/getuserprovider.dart';
import 'package:tempalteflutter/modules/setting/views/provider/aboutusprovider.dart';
import 'package:tempalteflutter/modules/setting/views/provider/getcontactusprovider.dart';
import 'package:tempalteflutter/modules/setting/views/provider/getfantasyhelpprovider.dart';
import 'package:tempalteflutter/modules/setting/views/provider/getfaqprovider.dart';
import 'package:tempalteflutter/modules/setting/views/provider/getlegalityprovider.dart';
import 'package:tempalteflutter/modules/setting/views/provider/getresponsiblegamingprovider.dart';
import 'package:tempalteflutter/modules/setting/views/provider/privacypolicyprovider.dart';
import 'package:tempalteflutter/modules/setting/views/provider/termsandconditionprovider.dart';
import 'package:tempalteflutter/modules/standingScreen/views/provider/completematchprovider.dart';
import 'package:tempalteflutter/modules/standingScreen/views/provider/fantasyplayerointprovider.dart';
import 'package:tempalteflutter/modules/standingScreen/views/provider/livematchesprovider.dart';
import 'package:tempalteflutter/modules/standingScreen/views/provider/upcomingmatchesprovider.dart';


List<SingleChildWidget> blocAndProviderList(context) {
  return [
    ChangeNotifierProvider(create: (context) => GetUserDataProvider(context)),
    ChangeNotifierProvider(create: (context) => GettermsandconProvider(context)),
    ChangeNotifierProvider(create: (context) => PrivacyPolicyProvider(context)),
    ChangeNotifierProvider(create: (context) => GetAboutUsProvider(context)),
    ChangeNotifierProvider(create: (context) => FantasyLegalityProvider(context)),
    ChangeNotifierProvider(create: (context) => FantasyFaqProvider(context)),
    ChangeNotifierProvider(create: (context) => FantasyHelpProvider(context)),
    ChangeNotifierProvider(create: (context) => ContactusProvider(context)),
    ChangeNotifierProvider(create: (context) => ResponsibleGamingProvider(context)),
    ChangeNotifierProvider(create: (context) => GetOffersandProgramProvider(context)),
    ChangeNotifierProvider(create: (context) => GetPlayerDetailsProvider(context)),
    ChangeNotifierProvider(create: (context) => SelectedPlayersProvider()),
    ChangeNotifierProvider(create: (context) => GetUserAllTransactionProvider(context)),
    ChangeNotifierProvider(create: (context) => GetUserNotificationProvider(context)),
    ChangeNotifierProvider(create: (context) => GetTeamByMatchIdProvider(context)),
    ChangeNotifierProvider(create: (context) => GetUpcomingMatchProvider(context)),
    ChangeNotifierProvider(create: (context) => GetContestByMatchProvider(context)),
    ChangeNotifierProvider(create: (context) => GetJoinedContestProvider(context)),
    ChangeNotifierProvider(create: (context) => GetBannerProvider(context)),
    ChangeNotifierProvider(create: (context) => GetUpcomingMatchesProvider(context)),
    ChangeNotifierProvider(create: (context) => GetLiveMatchesProvider(context)),
    ChangeNotifierProvider(create: (context) => GetCompleteMatchesProvider(context)),
    ChangeNotifierProvider(create: (context) => Player11Provider()),
    ChangeNotifierProvider(create: (context) => GetFantasyPlayerPointProvider(context)),
    ChangeNotifierProvider(create: (context) => GetLiveMatchProvider(context)),
  ];
}
