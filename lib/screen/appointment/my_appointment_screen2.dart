import 'package:moryim/components/custom_app_bar.dart';
import 'package:moryim/constants.dart';
import 'package:moryim/models/AvailableDoctor.dart';
import 'package:moryim/screen/appointment/Bookment.dart';
import 'package:flutter/material.dart';
import 'package:moryim/screen/components/docotor_card.dart';

class MyAppointmentScreen2 extends StatefulWidget {
  const MyAppointmentScreen2({Key key}) : super(key: key);

  @override
  _MyAppointmentScreen2 createState() => _MyAppointmentScreen2();
}

class _MyAppointmentScreen2 extends State<MyAppointmentScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(text: "Doctor"),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: demoAvailableDoctors.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: defaultPadding,
                    mainAxisSpacing: defaultPadding,
                  ),
                  itemBuilder: (context, index) => DoctorCard(
                    doctor: demoAvailableDoctors[index],
                    press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Bookment(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
