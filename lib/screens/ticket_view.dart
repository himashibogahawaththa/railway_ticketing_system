import 'package:flutter/material.dart';
import 'package:railway_ticketing/utils/app_layout.dart';
import 'package:railway_ticketing/utils/app_styles.dart';

class TicketView extends StatelessWidget {
  const TicketView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: 200,
        child: Container(
          margin: EdgeInsets.only(left: 16,right: 16),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF526799),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(21),
                  topRight: Radius.circular(21))
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Colombo Fort", style: Styles.headLineStyle3.copyWith(color: Colors.white)),
                        Spacer(),
                        Text("Galle", style: Styles.headLineStyle3.copyWith(color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
