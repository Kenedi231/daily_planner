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
            color: Theme.of(context).primaryColor,
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
                    color: Theme.of(context).textTheme.body2.color,
                  ),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 15.0),
                child: Text(
                  viewModel.dateFormating(item.date),
                  style: TextStyle(
                    color: Theme.of(context).textTheme.display1.color,
                    fontSize: 16,
                  ),
                ),
              ),
              trailing: viewModel.deleteMode
                ? Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: Theme.of(context).textTheme.body2.color,
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
                    color: Theme.of(context).textTheme.body2.color,
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
    // var i18n = AppLocalizations.of(context).translate;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: AnimatedList(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
        key: viewModel.noteListKey,
        initialItemCount: viewModel.listNotes.length,
        itemBuilder: (context, index, animation) {
          return buildItem(context, viewModel.listNotes[index], animation, viewModel.listForDelete.contains(index));
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (viewModel.deleteMode) {
            viewModel.runMultipleDelete(buildItem);
          } else {
            viewModel.createNewNotes();
          }
        },
        child: Icon(
          viewModel.deleteMode ? Icons.delete : Icons.add,
          size: 40,
          color: Theme.of(context).iconTheme.color
        ),
        backgroundColor: Theme.of(context).primaryColor,
        heroTag: 'note-create',
      ),
    );
  }
}