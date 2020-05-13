import 'package:flutter/material.dart';

void showActionSheet(context, child) => showModalBottomSheet(
  context: context, 
  backgroundColor: Colors.transparent,
  isScrollControlled: true,
  builder: (context) {
    return SingleChildScrollView(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(45.0),
          topRight: const Radius.circular(45.0)
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 25, 10, MediaQuery.of(context).viewInsets.bottom),
          color: Theme.of(context).backgroundColor,
          child: SafeArea(
            child: child
          ),
        ),
      ),
    );
  }
);