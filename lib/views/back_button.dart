import 'package:flutter/material.dart';

class BackBtn extends StatelessWidget {
  final VoidCallback onPressed;

  const BackBtn({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
                          onPressed: onPressed,
                          child: Icon(Icons.arrow_back,color: Colors.blueGrey.shade900,),
                          
                          style: OutlinedButton.styleFrom(
                             side: BorderSide(color:Colors.blueGrey.shade900, width: 3), 
                          
                            
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                        );
  }
}
