import 'package:flutter/material.dart';
import 'package:students_db/db/database_helper.dart';
import 'package:students_db/model/student.dart';
import 'package:students_db/routes/student_list.dart';

class AddStudent extends StatefulWidget {

  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {

  var formKey = GlobalKey<FormState>();

  late String name, course, mobile, totalFee, feePaid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Name',
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),

                    ),

                  ),
                  validator: (value){
                    if( value == null || value.isEmpty){
                      return 'Please provide name';
                    }
                    else{
                      name = value;
                      return null;
                    }
                  },
                ),
                SizedBox(height: 8,),

                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Course',
                    labelText: 'Course',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),

                    ),

                  ),
                  validator: (value){
                    if( value == null || value.isEmpty){
                      return 'Please provide course';
                    }
                    else{
                      course = value;
                      return null;
                    }
                  },
                ),
                SizedBox(height: 8,),


                TextFormField(
                  maxLength: 11,
                  decoration: InputDecoration(
                    hintText: 'Mobile',
                    labelText: 'Mobile',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),

                    ),

                  ),
                  validator: (value){
                    if( value == null || value.isEmpty){
                      return 'Please provide mobile';
                    }
                    else{
                      mobile = value;
                      return null;
                    }
                  },
                ),
                SizedBox(height: 8,),


                TextFormField(
                  keyboardType: TextInputType.number,

                  decoration: InputDecoration(
                    hintText: 'Total Fee',
                    labelText: 'Total Fee',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),

                    ),

                  ),
                  validator: (value){
                    if( value == null || value.isEmpty){
                      return 'Please provide total fee';
                    }
                    else{
                      totalFee = value;
                      return null;
                    }
                  },
                ),
                SizedBox(height: 8,),

                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Fee Paid',
                    labelText: 'Fee Paid',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),

                    ),

                  ),
                  validator: (value){
                    if( value == null || value.isEmpty){
                      return 'Please provide fee paid';
                    }
                    else{
                      feePaid = value;
                      return null;
                    }
                  },
                ),
                SizedBox(height: 8,),

                ElevatedButton(onPressed: () async{

                  if( formKey.currentState!.validate()){
                    print('all good');

                    var student = Student.withId(null, name, course, mobile, int.parse(totalFee), int.parse(feePaid));
                    var result = await DatabaseHelper.instance.insertStudent(student);

                    if( result > 0){
                      print('Added');
                    }else{
                      print('Failed');
                    }
                  }else{
                    print('Not all filled');
                  }

                }, child: Text('Save')),
                SizedBox(height: 8,),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return StudentList();
                  }));
                }, child: Text('View All'),
                style: ElevatedButton.styleFrom(primary: Colors.green),),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
