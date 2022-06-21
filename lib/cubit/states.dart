abstract class BankStates{}
class InitialState extends BankStates{}

class crateDataBaseSuccessState extends BankStates{}
class crateDataBaseErrorState extends BankStates{
  var error;
  crateDataBaseErrorState(this.error);
}

class insertDataBaseSuccessState extends BankStates{}
class insertDataBaseErrorState extends BankStates{
  var error;
  insertDataBaseErrorState(this.error);
}
class dataOpenedSuccess extends BankStates{}
class dataOpenedErrorState extends BankStates{
  var error;
  dataOpenedErrorState(this.error);
}

class sendMonySuccess extends BankStates{}
class sendMonyFail extends BankStates{}

