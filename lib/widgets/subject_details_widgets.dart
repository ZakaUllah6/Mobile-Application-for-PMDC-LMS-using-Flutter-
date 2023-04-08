import 'package:flutter/material.dart';

import '../constants/constants.dart';

class SubjectDetailsWidgets extends StatelessWidget {
  const SubjectDetailsWidgets({
    required this.subjectName,
    Key? key,
  }) : super(key: key);
  final String subjectName;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5,),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1,color: Colors.grey.withOpacity(.2))

      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            ///Container For Subject Image
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color:  kBlueColor.withOpacity(.2),
                borderRadius: BorderRadius.circular(30),

              ),
              child: Image.asset('assets/images/subject_img.png'),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 ///Row for Subject Name and View Btn
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(subjectName.toString(),style: kTextStyle),
                      Container(
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: kAppColor
                                  ),
                                  child: const Text('view',textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color: Colors.white),),
                                ),
                    ],
                  ),
                  const SizedBox(height: 6,),
                  ///Row for Icons And Texts
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                          Text('Test Date:',style: TextStyle(fontSize: 10),),

                          Text('27-Jan-2023',style: TextStyle(fontSize: 10.5),),




                          Text('Status:',style: TextStyle(fontSize: 10),),
                          Text('Attempted',style: TextStyle(fontSize: 10.5,color: Colors.green),)



                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
      // child: ListTile(
      //     leading: Container(
      //       height: 50,
      //       width: 50,
      //       decoration: BoxDecoration(
      //         color:  kBlueColor.withOpacity(.2),
      //         borderRadius: BorderRadius.circular(30),
      //
      //       ),
      //       child: Image.asset('assets/images/subject_img.png'),
      //     ),
      //     title:   Text(subjectName.toString(),style: kTextStyle),
      //
      //
      //     subtitle: Expanded(
      //       flex: 1,
      //       child: Row(
      //         children: [
      //
      //                  Icon(Icons.calendar_today_outlined,size: 15,color: Colors.black,),
      //                 Text('Test Date:',style: TextStyle(fontSize: 10),),
      //                 Text('27-Jan-2023',style: TextStyle(fontSize: 10),),
      //
      //                 const Icon(Icons.refresh,size: 15,color: Colors.black,),
      //                 Text('Status:',style: TextStyle(fontSize: 10),),
      //                 Text('Attempted',style: TextStyle(fontSize: 10,color: Colors.green),),
      //
      //         ],
      //       ),
      //     ),
      //
      //     trailing: Column(
      //       children: [
      //         Container(
      //           width: 40,
      //           decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(5),
      //               color: kAppColor
      //           ),
      //           child: Text('view',textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color: Colors.white),),
      //         ),
      //         SizedBox(height: 20,),
      //         Container(
      //           width: 40,
      //           decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(5),
      //               color: kAppColor
      //           ),
      //           child: Text('view',textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color: Colors.white),),
      //         ),
      //       ],
      //     )
      // ),
    );
  }
}
