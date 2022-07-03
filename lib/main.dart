import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main()
{
  runApp(Calculator());
}

class Calculator extends StatelessWidget
{
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: SimpleCalculator(),
    );
  }
}
class SimpleCalculator extends StatefulWidget
{
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();

}

class _SimpleCalculatorState extends State<SimpleCalculator>
{
  String equation ="0";
  String result ="0";
  String expression ="";
  double resultFontSize=40;
  double equationFontSize= 30;
  buttonPressed(String buttonText)
  {
    setState (()
    {
      if(buttonText=="C")      //////// For clear expression
        {
          equation="0";
          result="0";
          double resultFontSize=48.0;
          double equationFontSize= 38.0;
        }
      else if(buttonText=="⌫")          ////////// For clearing last entry
      {
        double resultFontSize=38.0;
        double equationFontSize= 48.0;
        equation=equation.substring(0,equation.length-1);
        if(equation==""){
          equation="0";
        }
      }
      else if(buttonText=="=")            /////////// For calculating answer
        {
          double resultFontSize=48.0;
          double equationFontSize= 38.0;
          expression=equation;
          expression =expression.replaceAll('×', '*');
          expression =expression.replaceAll('÷', '/');

          try{
            Parser p =new Parser();
            Expression exp = p.parse(expression);
            ContextModel cm= ContextModel();
            result= '${exp.evaluate(EvaluationType.REAL, cm)}';
          }catch(e){
            result="Error";
          }
        }
      else
        if(equation =="0")                 ///////////  Initial entry=0
        {
          double resultFontSize=30.0;
          double equationFontSize= 40.0;
          equation=buttonText;
        }
        else
          equation=equation+buttonText;
    });
  }
  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor)
  {
    return Container(
      height: MediaQuery.of(context).size.height *.1*buttonHeight,
      color: buttonColor,
      padding: EdgeInsets.all(8.0),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey.shade900),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),
        ),
        ),
        ),
        onPressed:()=> buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

      ),
    );
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('CALCULATOR',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),

        ),
        backgroundColor: Colors.blueGrey.shade800,
      ),
      backgroundColor: Colors.blueGrey.shade700,
      body: Column(
        children: <Widget>[
          Container(                                           /////////////  input screen in calculator
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation,style: TextStyle(fontSize: equationFontSize,
            fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 255, 255, 1)
            ),
            ),
          ),
          Container(                                        /////////////////////// output screen in calculator
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(result,style: TextStyle(fontSize: resultFontSize,
            fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            ),
          ),
          Expanded(
            child: Divider(

            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width* .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                       buildButton('C', 1, Colors.redAccent),
                        buildButton("⌫",1, Colors.white),
                        buildButton("÷", 1, Colors.white),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("7", 1, Colors.white),
                        buildButton("8",1, Colors.white),
                        buildButton("9", 1, Colors.white),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, Colors.white),
                        buildButton("5",1, Colors.white),
                        buildButton("6", 1, Colors.white),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("1", 1, Colors.white),
                        buildButton("2",1, Colors.white),
                        buildButton("3", 1, Colors.white),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton(".", 1, Colors.white),
                        buildButton("0",1, Colors.white),
                        buildButton("00", 1, Colors.white),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width *.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("×",1, Colors.white),
                      ]
                    ),
                    TableRow(
                        children: [
                          buildButton("-",1, Colors.white),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("+",1, Colors.white),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("=",2, Colors.white),
                        ]
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

