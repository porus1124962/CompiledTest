import 'package:flutter/material.dart';
import 'package:karachi_hills_project/model/agent_register_model.dart';

class GetRegistrationProvider extends ChangeNotifier{

  AgentRegister? _registerFormModel;
  AgentRegister? get registerFormModel => _registerFormModel;

  List agentRegistrationList = [];

  void setRegisterForms(AgentRegister? registerFormModel) {
    _registerFormModel = registerFormModel;
    notifyListeners();
  }

  Future restRegisterFormsProvider() async {
    _registerFormModel = null;
    notifyListeners();
  }


 Future setAgentRegistrationList(data)async{
    agentRegistrationList.add(data);
    notifyListeners();
  }

  Future resetAgentRegistrationList()async{
    agentRegistrationList = [];
    notifyListeners();
  }

}