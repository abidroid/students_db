class Student {
  late int? id;
  late String name;
  late String course;
  late String mobile;
  late int totalFee;
  late int feePaid;

  Student(this.name, this.course, this.mobile, this.totalFee, this.feePaid);

  Student.withId(this.id, this.name, this.course, this.mobile, this.totalFee,
      this.feePaid);

  // convert a Student object into map object

  Map<String, dynamic> toMap(){
    var map  = Map<String, dynamic>();

    if( id != null ){
      map['id'] = id;
    }

    map['name'] = name;
    map['course'] = course;
    map['mobile'] = mobile;
    map['totalFee'] = totalFee;
    map['feePaid'] = feePaid;
    return map;
  }


  // Extract a student object from a map object
  Student.fromMap(Map<String, dynamic> map){

      id = map['id'];
      name = map['name'];
      course = map['course'];
      mobile = map['mobile'];
      totalFee = map['totalFee'];
      feePaid = map['feePaid'];

  }
}
