part of person_view;

class _Person extends StatelessWidget {
  final PersonViewModel viewModel;

  _Person(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Person')),
    );
  }
}