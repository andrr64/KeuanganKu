class SQLModelUserdata {
  int id;
  String? username;
  SQLModelUserdata({
    required this.id,
    required this.username
  });

  toJson(){
    return {
      'id' : id,
      'username': username
    };
  }

  factory SQLModelUserdata.fromJson(Map<String, dynamic> data){
    return SQLModelUserdata(
        id: data['id'],
        username: data['username']
    );
  }
}