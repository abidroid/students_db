import 'package:flutter/material.dart';
import 'package:students_db/db/database_helper.dart';
import 'package:students_db/model/student.dart';
import 'package:students_db/routes/update_student.dart';

class StudentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students List'),
      ),
      body: FutureBuilder<List<Student>>(
        future: DatabaseHelper.instance.getAllStudents(),
        builder: (BuildContext context, AsyncSnapshot<List<Student>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text('Loading...'));
          } else if (snapshot.data!.isEmpty) {
            return Center(
              child: Text('No Students Yet'),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var student = snapshot.data![index];
                  return Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${student.name}',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text('Course'),
                            ),
                            Expanded(
                              child: Text('${student.course}'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text('Mobile'),
                            ),
                            Expanded(
                              child: Text('${student.mobile}'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text('Total Fee'),
                            ),
                            Expanded(
                              child: Text('${student.totalFee}'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text('Fee Paid'),
                            ),
                            Expanded(
                              child: Text('${student.feePaid}'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red),
                                child: Text('Delete'),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Confirmation'),
                                          content: Text('Are you sure to Delete ?'),
                                          actions: [
                                            TextButton(onPressed: (){
                                              Navigator.pop(context);
                                            }, child: Text('No')),
                                            TextButton(onPressed: () async{

                                              var result = await DatabaseHelper.instance.deleteStudent(student.id!);
                                              if( result > 0 ){
                                                Navigator.pop(context);
                                                setState(() {

                                                });
                                              }

                                            }, child: Text('Yes')),

                                          ],
                                        );
                                      });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green),
                                child: Text('Update'),
                                onPressed: () async {
                                  var result = await Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return UpdateStudent(student);
                                  }));

                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
