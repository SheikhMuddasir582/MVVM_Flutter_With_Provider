import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeViewViewModel homeViewViewModel= HomeViewViewModel();

  @override
  void initState() {
    // TODO: implement initState
    homeViewViewModel.fetchMoviesListApi();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home Screen'),
        actions: [
          InkWell(
              onTap: (){
                userPreference.remove().then((value){
                  Navigator.pushNamed(context, RouteName.login);
                });
              },
              child: Center(child: Text('Logout'))),
          SizedBox(width: 20,),
        ],
      ),
      body: ChangeNotifierProvider<HomeViewViewModel>(
        create: (BuildContext context) => homeViewViewModel,
        child: Consumer<HomeViewViewModel>(
          builder: (context, value, _){
            switch(value.productlist.status){
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Center(child: Text(value.productlist.message.toString()));
              case Status.COMPLETED:
                return ListView.builder(
                    itemCount: value.productlist.data!.products!.length,
                    itemBuilder: (context, index){
                      return Card(
                        child: ListTile(
                          // leading: Image.network(
                          //   value.userList.data.title.toString(),
                          //   errorBuilder: (context, error, stack){
                          //     return Icon(Icons.error);
                          //   },
                          //   height: 40,
                          //   width: 40,
                          //   fit: BoxFit.cover,
                          // ),
                          title: Text(value.productlist.data!.products![index].discountPercentage.toString()),
                          subtitle: Text(value.productlist.data!.products![index].rating.toString()) ,
                          // trailing: Row(
                          //   children: [
                          //
                          //   ],
                          // ),
                        ),
                      );
                    }
                );
              case null:
                if(Status.COMPLETED.toString() == 'null') {
                  return Text('null value');
                }

              
            };
            return Container();
          }),
      ),
    );
  }
}
