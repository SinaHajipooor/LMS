import 'package:flutter/material.dart';
import 'package:lms/helpers/connections/internet_connectivity_helper.dart';
import 'package:lms/helpers/theme/theme_helper.dart';
import 'package:lms/providers/Profile/Compilations/CompilationsProvider.dart';
import 'package:lms/widgets/elements/spinner.dart';
import 'package:lms/widgets/profile/compilations/compilations_info.dart';
import 'package:lms/widgets/profile/compilations/compilations_modal.dart';
import 'package:provider/provider.dart';

class CompilationsAndTranslationsScreen extends StatefulWidget {
  static const routeName = '/compilations-and-translations-screen';
  const CompilationsAndTranslationsScreen({super.key});

  @override
  State<CompilationsAndTranslationsScreen> createState() => _CompilationsAndTranslationsScreenState();
}

class _CompilationsAndTranslationsScreenState extends State<CompilationsAndTranslationsScreen> {
// -------------- state ---------------
  bool _isLoading = true;
  List<dynamic> compilations = [];
  // ----------- lifecycle -------------
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInternetConnectivity(context);
    });
    fetchAllCompilations();
    super.initState();
  }

  // --------------- methods -----------------
  Future<void> fetchAllCompilations() async {
    await Provider.of<CompilationsProvider>(context, listen: false).fetchAllCompilations();
    setState(() {
      compilations = Provider.of<CompilationsProvider>(context, listen: false).compilations;
      _isLoading = false;
    });
  }

  Future<void> deleteCompilation(int compilationId, int index) async {
    final compilationCopy = List.from(compilations);
    compilationCopy.removeAt(index);
    await Provider.of<CompilationsProvider>(context, listen: false).deleteCompilation(compilationId);
    setState(() {
      compilations = compilationCopy;
    });
    Navigator.of(context).pop();
  }

  void _checkInternetConnectivity(BuildContext context) {
    InternetConnectivityHelper.checkInternetConnectivity(context);
  }

  _showCompilationsmModal(BuildContext ontext, double deviceHeight) {
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
        return CompilationsModal(
          fetchAllCompilations: fetchAllCompilations,
          deviceHeight: deviceHeight,
          isCreating: true,
          isEditing: false,
          isShowing: false,
          title: 'ایجاد تالیفات و ترجمات',
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
        title: Text('تالیفات و ترجمات', style: theme.textTheme.titleMedium),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.appBarTheme.iconTheme!.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(onPressed: () => _showCompilationsmModal(context, deviceSize.height), icon: Icon(Icons.add, color: themeMode == ThemeMode.light ? Colors.blue : Colors.white)),
        ],
      ),
      body: _isLoading
          ? const Center(child: Spinner(size: 35))
          : CompilationsInfo(
              fetchAllCompilation: fetchAllCompilations,
              deleteCompilation: deleteCompilation,
              compilations: compilations,
            ),
    );
  }
}
