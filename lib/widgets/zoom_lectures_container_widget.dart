import 'package:flutter/material.dart';

import '../constants/constants.dart';
class ZoomLecturesContainerWidget extends StatelessWidget {
  const ZoomLecturesContainerWidget({
    required  this.containerColor,
    required this.subjectName,
    Key? key,
  }) : super(key: key);

  final Color containerColor;
  final String subjectName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: 220,
        decoration:BoxDecoration(
          borderRadius:  BorderRadius.circular(10),
          color: containerColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.folder_sharp,size: 30,color: Colors.white,),
                      SizedBox(width: 10,),
                      Text('Chapter No. 1',style: TextStyle(color: Colors.white,fontSize: 17),)

                    ],
                  ),
                  const Text('Operating System',style: TextStyle(color: Colors.white,fontSize: 17),)
                ],
              ),

               Padding(
                padding:  const EdgeInsets.only(top: 20.0),
                child: Text(subjectName.toString(),textAlign: TextAlign.justify,style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(child:  Text('Watch',style: TextStyle(fontSize: 18,color: kLightBlueColor,fontWeight: FontWeight.bold),),),
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Test Date:',style: TextStyle(color: Colors.white,fontSize: 10)),
                    Text('27-Jan-2023',style: TextStyle(color: Colors.white,fontSize: 11)),
                    Text('Teacher: ',style: TextStyle(color: Colors.white,fontSize: 10)),
                    Text('Muhammad Ishaq',style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold)),


                  ],
                ),
              ),

            ],
          ),
        )
        ,
      ),
    );
  }
}
