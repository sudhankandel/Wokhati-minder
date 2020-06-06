import 'package:flutter/material.dart';
import 'package:signup/pages/pill/models/medicine.dart';
import 'package:signup/pages/pill/ui/medicine_details/medicine_details.dart';
class MedicineInfo {
  final Medicine medicine;
  MedicineInfo(this.medicine);
  

 openAlertBox(BuildContext context) {
    return showDialog(

        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 400.0,
              height: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        "Medicine Info",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Column(children: <Widget>[
                Row(
                //ROW 1
                children: [
                  Container(
                    height: 65.0, 
                    margin: EdgeInsets.only(left:10.0),
                     child: MainInfoTab(
                    fieldTitle: "Name",
                    fieldInfo: medicine.medicineName,
                  ),
                  ),
                  Container(
                    height: 65.0, 
                    margin: EdgeInsets.only(left:25.0),
                     child:  MainInfoTab(
                  fieldTitle: "Medicine Type",
                  fieldInfo: medicine.medicineType == "None"
                      ? "nan"
                      : medicine.medicineType,
                   ),
                  ),
                ],
              ),
              Row(
                //ROW 1
                children: [
                  Container(
                     height: 65.0,
                    margin: EdgeInsets.only(left:10.0),
                     child: MainInfoTab(
                    fieldTitle: "Dose",
            fieldInfo:medicine.interval.toString() +" hours" 
                  ),
                  ),
                  Container(
                height: 65.0,  
                margin: EdgeInsets.only(left:25.0),
                child:   MainInfoTab(
                fieldTitle: "Dosage",
                fieldInfo: medicine.dosage == 0
                    ? "nan"
                    : medicine.dosage.toString() + " mg",
              )
                  ),
                ],
              ),
                Row(
                //ROW 1
                children: [
                  Container(
                     height: 65.0,
                    margin: EdgeInsets.only(left:10.0),
                     child: MainInfoTab(
                    fieldTitle: "Interval",
            fieldInfo: 
                "${medicine.interval == 24 ? "One time a day" : (24 / medicine.interval).floor().toString() + " times"}",
                  ),
                  ),
                  Container(
                height: 65.0,  
                margin: EdgeInsets.only(left:25.0),
                child:   MainInfoTab(
                fieldTitle: "Remain",
                fieldInfo: medicine.dosage == 0
                    ? "nan"
                    : medicine.dosage.toString() + " pcs",
              )
                  ),
                ],
              ),

                  ],),
               
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width /7,
                            height:MediaQuery.of(context).size.width /9,
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            decoration: BoxDecoration(
                              color: Colors.blue,

                            ),
                            child: Text(
                              "Ok",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
class MainSection extends StatelessWidget {
  final Medicine medicine;

  MainSection({
    Key key,
    @required this.medicine,
  }) : super(key: key);
 @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Hero(
                tag: medicine.medicineName,
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                     "Name: "+medicine.medicineName,
                  ),
                ),
              ),
              MainInfoTab(
                fieldTitle: "Dosage",
                fieldInfo: medicine.dosage == 0
                    ? "Not Specified"
                    : medicine.dosage.toString() + " mg",
              )
            ],
          )
        ],
      ),
    );
  }
}