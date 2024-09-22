class DropdownModel {
  final int id;
  final String name;
  var additionlValue;

  DropdownModel(this.id, this.name,{this.additionlValue});
  factory DropdownModel.selectItem(String title)=>DropdownModel(0, title);
}
class DropdownModelForThreeValue {
  final int id;
  final String name;
  final String name1;
  final String name2;
  var additionlValue;

  DropdownModelForThreeValue(this.id, this.name,this.name1, this.name2,{this.additionlValue});
  factory DropdownModelForThreeValue.selectItem(String title, String title1, String title2)=>DropdownModelForThreeValue(0, title, title1, title2);
}

class DropdownModelForData {
  final String title;
  final String name;
  var additionlValue;

  DropdownModelForData(this.title, this.name,{this.additionlValue});
  factory DropdownModelForData.selectItem(String title)=>DropdownModelForData('', title);
}