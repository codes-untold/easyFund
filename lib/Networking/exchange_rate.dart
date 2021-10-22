import 'package:http/http.dart' as http;


class ExchangeRate{

  String api_key = "e851c171e65cfb4825923010";

  Future <http.Response?> fetchData(String currency)async{


      http.Response response = await http.get(Uri.parse("https://v6.exchangerate-api.com/v6/$api_key/latest/$currency"));
      return response;

  }
}