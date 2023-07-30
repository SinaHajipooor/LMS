import 'package:flutter/material.dart';
import 'package:lms/helpers/internet_connectivity_helper.dart';
import 'package:lms/helpers/theme_helper.dart';
import 'package:lms/providers/Profile/Teaching/UniversityTeachingProvider.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:lms/widgets/profile/teaching/university/university_teaching_info.dart';
import 'package:lms/widgets/profile/teaching/university/university_teaching_modal.dart';
import 'package:provider/provider.dart';

class UniversityTeachingHistoryScreen extends StatefulWidget {
  static const routeName = '/university-teaching-history-screen';
  const UniversityTeachingHistoryScreen({super.key});

  @override
  State<UniversityTeachingHistoryScreen> createState() => _UniversityTeachingHistoryScreenState();
}

class _UniversityTeachingHistoryScreenState extends State<UniversityTeachingHistoryScreen> {
  //---------- state ---------------
  List<dynamic> universityTeachings = [];
  bool _isLoading = true;
  // ----------- lifecycle -------------
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInternetConnectivity(context);
    });
    fetchAllUniveristyTeachings();
    super.initState();
  }

  // --------------- methods -----------------
  void _checkInternetConnectivity(BuildContext context) {
    InternetConnectivityHelper.checkInternetConnectivity(context);
  }

  Future<void> fetchAllUniveristyTeachings() async {
    await Provider.of<UniversityTeachingProvider>(context, listen: false).fetchAllUniversityTeachings();
    setState(() {
      universityTeachings = Provider.of<UniversityTeachingProvider>(context, listen: false).universityTeachings;
      _isLoading = false;
    });
  }

  Future<void> deleteUniversityTeaching(int id, int index) async {
    final universityTeachingsCopy = List.from(universityTeachings);
    universityTeachingsCopy.removeAt(index);
    await Provider.of<UniversityTeachingProvider>(context, listen: false).deleteUniversityTeaching(id);
    setState(() {
      universityTeachings = universityTeachingsCopy;
    });
    Navigator.of(context).pop();
  }

  _showUniversityTeachinModal(BuildContext context, double deviceHeight, int selectedIndex) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return UniversityTeachingModal(
          fetchAllUniversityTeachings: fetchAllUniveristyTeachings,
          title: 'ایجاد سوابق تدریس دانشگاهی',
          isCreating: true,
          isEditing: false,
          isShowing: false,
          deviceHeight: deviceHeight,
        );
      },
    );
  }

  //---------------- UI -------------------
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final themeMode = Provider.of<MyThemeModel>(context).themeMode;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Text('سوابق تدریس دانشگاهی', style: theme.textTheme.titleMedium),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.appBarTheme.iconTheme!.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(onPressed: () => _showUniversityTeachinModal(context, deviceSize.height, 1), icon: Icon(Icons.add, color: themeMode == ThemeMode.light ? Colors.blue : Colors.white)),
        ],
      ),
      body: _isLoading
          ? const Center(child: Spinner(size: 35))
          : UniversityTeachingInfo(
              deleteUniversityTeaching: deleteUniversityTeaching,
              fetchAllUniversityTeachings: fetchAllUniveristyTeachings,
              universityTeachings: universityTeachings,
            ),
    );
  }
}
