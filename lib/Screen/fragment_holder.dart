import 'package:flutter/material.dart';
import 'Listing_screen.dart';

class FragmentHolder extends StatefulWidget {

  const FragmentHolder({super.key});

  @override
  State<FragmentHolder> createState() => _FragmentHolderState();
}

class _FragmentHolderState extends State<FragmentHolder> {

  var data = [];

  void refreshList(dynamic value) {

    setState(() {

      data.add(value);

    });
  }

  @override
  Widget build(BuildContext context) {

    return Parkingscreen(

      data: data,

      refreshList: refreshList,

    );
  }
}