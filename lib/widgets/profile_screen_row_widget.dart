import 'package:flutter/material.dart';

class ProfileScreenRowWidget extends StatelessWidget {
  const ProfileScreenRowWidget({
    required this.text1,
    required this.value1,
    required this.text2,
    required this.value2,
    Key? key,
  }) : super(key: key);

  final text1, value1, text2, value2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey.withOpacity(.1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                value1.toString(),
                style: TextStyle(color: Colors.black87),
              ),
              Flexible(
                child: Text(
                  text2.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                value2.toString(),
                style: TextStyle(color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
