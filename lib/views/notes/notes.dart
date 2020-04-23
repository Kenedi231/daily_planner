part of notes_view;

class _Notes extends StatelessWidget {
  final NotesViewModel viewModel;

  _Notes(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Notes')),
    );
  }
}