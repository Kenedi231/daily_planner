part of notes_view;

class _Notes extends StatelessWidget {
  final NotesViewModel viewModel;

  _Notes(this.viewModel);

  Widget buildItem(BuildContext context, NoteModel item, Animation<double> animation) {
    return ScaleTransition(
      scale: animation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Hero(
          tag: item.heroTag,
          child: Card(
            color: Theme.of(context).primaryColor,
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  item.title,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.body2.color,
                  ),
                ),
              ),
              trailing: IconButton(
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
    var i18n = AppLocalizations.of(context).translate;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: AnimatedList(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
        key: viewModel.noteListKey,
        initialItemCount: viewModel.listNotes.length,
        itemBuilder: (context, index, animation) {
          return buildItem(context, viewModel.listNotes[index], animation);
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.createNewNotes();
        },
        child: Icon(Icons.add, size: 40, color: Theme.of(context).iconTheme.color),
        backgroundColor: Theme.of(context).primaryColor,
        heroTag: 'note-create',
      ),
    );
  }
}