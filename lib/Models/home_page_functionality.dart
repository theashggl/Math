class MyHomePageStateFunctionality {
  int _answer;

  MyHomePageStateFunctionality() {
    answer = 0;
  }

  int get getAnswer => _answer;

  set answer(int value) {
    _answer = value;
  }

  //Methods containing the logic of the functionality aiding in the functionality directly
//ToDo Create tests for the below two methods in the next push/commit
  int listGeneration(int dropdownValue, int lengthOfListOrRoundsOfGame) {
// gameNumbers = new List<int>.empty();
    int sum = 0;
    int temp = 1;
    sum += temp;
  }

  String rightOrWrong(int userCalculation) {
    if (userCalculation == getAnswer) {
      return "Right!!!";
    } else {
      return "Wrong";
    }
  }
}
