import 'package:practice/model/model.dart';
import 'package:sqflite/sqflite.dart';

class DB{
  static Database? _db;
  static int get _version => 1;

  static Future<void> init()async{
    if(_db!=null){
      return;
    }
    try {
        String _path = await getDatabasesPath() + 'task';
        //print(_path);
        _db = await openDatabase(_path, version: _version, onCreate: onCreate);
      }
      catch(e) {
        //print(e);
      }
  }
   static void onCreate(Database db, int version) async {
    db.execute("CREATE TABLE TASK ("
        "token TEXT,"
        "id TEXT,"
        "name TEXT,"
        "email TEXT"
        ")");
  }
  static Future<dynamic> insert(Users user) async{


    //var table = await _db!.rawQuery("SELECT MAX(id)+1 as id FROM Task");

    //int id = table.first!["id"];
    var raw = await _db!.rawInsert('INSERT INTO TASK(token, id, name, email)''VALUES(?,?,?,?)',[user.token, user.id, user.name, user.email]);
    return raw;
  }


   static Future<List<Users>> query() async {
   var res =  await  _db!.query("TASK");
   List<Users> usersList =[];
   for (int i=0;i<res.length;i++){
     usersList.add(Users(id: res[i]['id'].toString(), 
     token: res[i]['token'].toString(), 
     name: res[i]['name'].toString(), 
     email: res[i]['email'].toString(

     )));
   }
   return usersList;
   
   //res.isNotEmpty?print(res) :print('no task added');

  }

  static Future<int> delete () async{
   // db.execSQL("delete from "+ TABLE_NAME);
    int res = await _db!.rawDelete("delete from  TASK");
    return res;
  }

}