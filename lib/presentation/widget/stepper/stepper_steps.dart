enum StepsState { active, inActive, complete }

class Steps {
  String text;
  StepsState state;

  Steps(this.state, this.text);
}
