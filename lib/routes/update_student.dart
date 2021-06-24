import 'package:flutter/material.dart';
import 'package:students_db/db/database_helper.dart';
import 'package:students_db/model/student.dart';

class UpdateStudent extends StatefulWidget {
  final Student student;

  UpdateStudent(this.student);

  @override
  _UpdateStudentState createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  var nameController = TextEditingController();
  var courseController = TextEditingController();
  var mobileController = TextEditingController();
  var tfController = TextEditingController();
  var fpController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.student.name;
    courseController.text = widget.student.course;
    mobileController.text = widget.student.mobile;
    tfController.text = widget.student.totalFee.toString();
    fpController.text = widget.student.feePaid.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Student ${widget.student.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: courseController,
                  decoration: InputDecoration(
                    hintText: 'Course',
                    labelText: 'Course',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: mobileController,
                  maxLength: 11,
                  decoration: InputDecoration(
                    hintText: 'Mobile',
                    labelText: 'Mobile',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: tfController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Total Fee',
                    labelText: 'Total Fee',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: fpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Fee Paid',
                    labelText: 'Fee Paid',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (nameController.text.isEmpty) {
                        return;
                      }

                      Student s = Student.withId(
                        widget.student.id,
                        nameController.text,
                        courseController.text,
                        mobileController.text,
                        int.parse(tfController.text),
                        int.parse(fpController.text),
                      );

                      var result = await DatabaseHelper.instance.updateStudent(s);

                      if( result > 0){
                        Navigator.pop(context, 'yes');
                      }else{
                        print('Failed');
                      }
                    },
                    child: Text('Update')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
