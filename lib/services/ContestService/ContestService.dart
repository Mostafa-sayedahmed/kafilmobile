
// import 'package:dio/dio.dart';
import 'package:kafilmobile/model/ContestModel/ContestModel.dart';

// const String site = "https://jsonplaceholder.typicode.com/";


class contestServices{
  // String albumsLink = "albums";

  Future<List<Contestnetworkmodel>> albumData() async{
    List<Contestnetworkmodel> contest = [];
    // final dio = Dio();
    // try{
    //   final response = await dio.get('${site}${albumsLink}');
    //   response.data.forEach((ele){
    //     Contestnetworkmodel album = Contestnetworkmodel.fromJson(ele);
    //     albums.add(album);
    //   });
    //   print(response.data);
    // }catch(e){
    //   print(e);
    // }
    
    return contest ;
  }
}