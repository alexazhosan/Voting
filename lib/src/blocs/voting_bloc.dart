import 'dart:async';

import 'package:Voting/src/blocs/base_bloc.dart';
import 'package:Voting/src/models/enums/voting_results.dart';
import 'package:rxdart/rxdart.dart';

class VotingBloc extends BaseBloc {
  VotingBloc() {
    _questionNumberController.stream.listen(onQuestionNumberAdded);
    _questionController.stream.listen(onQuestionAdded);
  }

  int questionNum = 1;
  List<String> questions = ["Любите розовый цвет?", "Любите слонов?"];
  List<VotingResults> answers = new List();

  StreamController _questionNumberController = StreamController();
  Stream get questionNumber => _questionNumberStream.stream;
  final _questionNumberStream = BehaviorSubject<int>();
  Sink get addQuestionNumber => _questionNumberStream.sink;
  StreamSink get questionNumberSink => _questionNumberController.sink;

  StreamController _questionController = StreamController();
  Stream get question => _questionStream.stream;
  final _questionStream = BehaviorSubject<String>();
  Sink get addQuestion => _questionStream.sink;
  StreamSink get questionSink => _questionController.sink;

  onQuestionNumberAdded(data) async {
    addQuestionNumber.add(questionNum);
  }

  onQuestionAdded(data) async {
    addQuestion.add(questions[questionNum - 1]);
  }

  changeQuestionNumber(data) async {
    if(questionNum < questions.length) {
      questionNum = data;
    } else {
      navigateToResults();
    }
  }

  updateBloc() {
    questionNumberSink.add(null);
    questionSink.add(null);
  }

  navigateToMenu() {
    answers.clear();
    navigationService.navigateAndRemoveUntil("/");
  }

  navigateToResults() {
    questionNum = 1;
    updateBloc();
    navigationService.navigateAndRemoveUntil("results_list");
  }

  @override
  dispose() {
    _questionNumberController.close();
    _questionNumberStream.close();
    _questionController.close();
    _questionStream.close();
  }
}
