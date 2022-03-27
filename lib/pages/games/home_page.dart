import 'dart:async';
import 'package:final_620710732/models/api.dart';
import 'package:final_620710732/models/quiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Quiz>? _quizList;
  var _isLoading = true;
  int index = 0;
  var result = "";
  int incorrect = 0;
  var colors = "";

  @override
  void initState() {
    super.initState();
    _fetchquiz();
  }
  void _fetchquiz() async {
    List list = await Api().fetch('quizzes');
    setState(() {
      _quizList = list.map((item) => Quiz.fromJson(item)).toList();
      _isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? const Center(child: CircularProgressIndicator())
          : index < _quizList!.length-1
          ? _buildquiz(): _buildresult()

    );
  }
  Widget _buildquiz() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(_quizList![index].image, fit: BoxFit.cover,),
            Column(
              children: [
                for(int i =0;i<_quizList![index].choices.length;i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: (){
                                setState(() {
                                  if(_quizList![index].choices[i]==_quizList![index].answer){
                                    result = "Well done";
                                    colors = "green";
                                  }else{
                                    result = "Incorrect";
                                    colors = "red";
                                  }
                                  Timer(const Duration(seconds: 2), (){
                                    setState(() {
                                      if(_quizList![index].choices[i]==_quizList![index].answer){
                                        index++;
                                      }else{
                                        incorrect++;
                                      }
                                      result="";
                                    });
                                  });
                                });
                              },
                              child: Text(_quizList![index].choices[i])),
                        )
                      ],
                    ),
                  )
              ],
            ),
            if(result=="")
              const SizedBox(
                height: 30.0,
                width: 5.0,
              ),
            if(result!="")
              Text(
                result, style: TextStyle(
                  fontSize: 25.0,

              )
              )
          ],
        ),
      ),
    );
  }
  Widget _buildresult(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "END GAME",style: TextStyle(
              fontSize: 25.0,
            ),
            ),
            Text(
              'Incorrect $incorrect Times',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.red,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    index = 0;
                    incorrect = 0;
                    _quizList = null;
                    _isLoading = true;
                    _fetchquiz();
                  });
                },
              child: Text("New GAME",style: TextStyle(
                fontSize: 25.0,
              ),),),
            )
          ],
        ),
      ),
    );
  }

}
