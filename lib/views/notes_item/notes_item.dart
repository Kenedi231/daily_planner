part of notes_item_view;

class _NotesItem extends StatelessWidget {
  final NotesItemViewModel viewModel;

  _NotesItem(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done, size: 30, color: Theme.of(context).textTheme.title.color),
            onPressed: null
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: GestureDetector(
        onTap: viewModel.focusInput,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  reverse: false,
                  child: TextField(
                    autofocus: true,
                    focusNode: viewModel.focusNode,
                    controller: viewModel.noteController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration.collapsed(hintText: 'Enter note'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}