import 'package:flutter/material.dart';

void showActionSheet(context, children) => showModalBottomSheet(
  context: context, 
  builder: (context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        )
      ),
    );
  }
);