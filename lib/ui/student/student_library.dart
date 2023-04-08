import 'package:flutter/material.dart';
import 'package:pmdc_version_4_flutter/widgets/row_widget.dart';

import 'package:provider/provider.dart';

import '../../../widgets/lbrary_screen_container_widget.dart';
import 'home_screen/home_screen_provider.dart';

class StudentLibraryScreen extends StatelessWidget {
  const StudentLibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(builder: (context, model, ch) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Center(
                child: Text(
              'Library',
              style: TextStyle(color: Colors.black),
            ))),
        drawer: const Drawer(
          backgroundColor: Colors.orange,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              RowWidget(
                tileName: 'Issued Books',
                seeAllText: '',
                onTap: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              model.libraryBooks.isEmpty
                  ? Text(
                      "No Books issued yet",
                      textAlign: TextAlign.center,
                    )
                  : Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: model.libraryBooks.length,
                        itemBuilder: (context, index) =>
                            LibraryScreensConainerWidget(
                                libraryBooks: model.libraryBooks[index]),
                      ),
                    ),
            ],
          ),
        ),
      );
    });
  }
}
