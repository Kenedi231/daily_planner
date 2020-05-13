part of notes_view;

class _Notes extends StatelessWidget {
  final NotesViewModel viewModel;

  _Notes(this.viewModel);

  Widget buildItem(BuildContext context, NoteModel item, Animation<double> animation, bool delete) {
    return ScaleTransition(
      scale: animation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Hero(
          tag: item.heroTag,
          child: Card(
            color: item?.category?.color ?? Theme.of(context).primaryColor,
            child: ListTile(
              onLongPress: () {
                viewModel.multipleDelete(item);
              },
              title: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyText2.color,
                  ),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 15.0),
                child: Text(
                  viewModel.dateFormating(item.date),
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headline4.color,
                    fontSize: 16,
                  ),
                ),
              ),
              trailing: viewModel.deleteMode
                ? Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: Theme.of(context).textTheme.bodyText2.color,
                  ),
                  child: Checkbox(
                    activeColor: Theme.of(context).primaryColor,
                    value: delete,
                    onChanged: (_) {
                      viewModel.editItem(item);
                    }
                  ),
                )
                : IconButton(
                  onPressed: () {
                    viewModel.removeItem(item, buildItem);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).textTheme.bodyText2.color,
                  ),
                ),
              onTap: () {
                viewModel.editItem(item);
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var i18n = AppLocalizations.of(context).translate;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: <Widget>[
          viewModel.deleteMode
            ? Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('${viewModel.listForDelete.length == 0 ? i18n('None') : viewModel.listForDelete.length} ${i18n('selected')}'),
                    RaisedButton(
                      elevation: 0.0,
                      focusElevation: 0.0,
                      color: Theme.of(context).backgroundColor,
                      onPressed: viewModel.disableDeleteMode,
                      child: Text(
                        i18n('cancel'),
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2.color,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ) : DropdownDialog(viewModel: viewModel, buildItem: buildItem),
          Expanded(
            flex: 20,
            child: AnimatedList(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
              key: viewModel.noteListKey,
              initialItemCount: viewModel.listNotes.length,
              itemBuilder: (context, index, animation) {
                return buildItem(context, viewModel.listNotes[index], animation, viewModel.listForDelete.contains(index));
              }
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (viewModel.deleteMode) {
            viewModel.runMultipleDelete(buildItem);
          } else {
            // TODO: Temporary solution
            showNewCategorySheet(context);
            // viewModel.setCategory(viewModel.categories[0], buildItem);
            // viewModel.createNewNotes();
          }
        },
        child: Icon(
          viewModel.deleteMode ? Icons.delete : Icons.add,
          size: 40,
          color: Theme.of(context).iconTheme.color,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        heroTag: 'note-create',
      ),
    );
  }
}

class DropdownDialog extends StatelessWidget {
  const DropdownDialog({
    Key key,
    @required this.viewModel,
    @required this.buildItem,
  }) : super(key: key);
  final NotesViewModel viewModel;
  final Function buildItem;

  @override
  Widget build(BuildContext context) {
    return DropdownDialogWidget(
      items: viewModel.categories.map<DropdownMenuItem<CategoryModel>>((CategoryModel item) {
        return DropdownMenuItem<CategoryModel>(
          child: Row(
            children: <Widget>[
              Icon(item.icon, color: item.color),
              SizedBox(width: 10),
              Text(item.name),
            ],
          ),
          value: item,
        );
      }).toList(),
      selectedValue: viewModel.currentCategory,
      onChanged: (value) {
        viewModel.setCategory(value ?? viewModel.currentCategory, buildItem);
      },
    );
  }
}