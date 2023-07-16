import 'package:flutter/material.dart';
import 'package:lms/helpers/ThemeHelper.dart';
import 'package:lms/widgets/profile/compilations/compilations_modal.dart';
import 'package:provider/provider.dart';

class CompilationsInfo extends StatefulWidget {
  final List<dynamic> compilations;
  final Function(int id, int index) deleteCompilation;
  final Function() fetchAllCompilation;
  const CompilationsInfo({super.key, required this.compilations, required this.deleteCompilation, required this.fetchAllCompilation});

  @override
  State<CompilationsInfo> createState() => _CompilationsInfoState();
}

class _CompilationsInfoState extends State<CompilationsInfo> {
  // -------------- methods ---------------
  _showCompilationsModal(
    BuildContext context,
    int compilationId,
    int useCase,
  ) {
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
          fetchAllCompilations: widget.fetchAllCompilation,
          deviceHeight: MediaQuery.of(context).size.height,
          title: useCase == 1 ? 'ویرایش تالیفات و ترجیمات' : 'جزئیات تالیفات و ترجمات',
          compilationId: compilationId,
          isEditing: useCase == 1,
          isShowing: useCase == 2,
          isCreating: false,
        );
      },
    );
  }

  // -------------- UI ---------------

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<MyThemeModel>(context).themeMode;
    final theme = Theme.of(context).textTheme;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.compilations.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: themeMode == ThemeMode.dark ? Theme.of(context).cardTheme.color : Colors.grey[300],
            child: Text((index + 1).toString()),
          ),
          title: Text(
            widget.compilations[index]['title'],
            style: theme.bodyMedium!.copyWith(fontSize: 14),
          ),
          subtitle: Text(widget.compilations[index]['publish_place'], style: theme.bodySmall!.copyWith(fontSize: 11)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: Colors.orange,
                radius: 15,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white, size: 15),
                  onPressed: () => _showCompilationsModal(context, widget.compilations[index]['id'], 1),
                ),
              ),
              const SizedBox(width: 5),
              InkWell(
                onTap: () => widget.deleteCompilation(widget.compilations[index]['id'], index),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.red,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white, size: 15),
                      onPressed: () => widget.deleteCompilation(widget.compilations[index]['id'], index),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
