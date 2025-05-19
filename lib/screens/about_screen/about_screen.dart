import 'package:flutter/material.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';
import 'package:luggage_tracking/widgets/texts/app_text.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "About"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              AppText(
                textAlign: TextAlign.justify,
                data:
                    """Quis urna. tempor consectetur risus quis dui. Ut leo. malesuada gravida eget ex. viverra Nunc Nunc dignissim, convallis. odio non sapien sed Praesent at sit luctus elit. leo. amet, urna viverra ac turpis Nunc elit. massa ipsum elit sed id  ipsum elit. enim. laoreet efficitur. eget maximus vitae nisi nisl. placerat ex ex. ex ac faucibus faucibus elit sit ex. nibh hendrerit Ut Nunc Ut non, Ut nec tincidunt tincidunt turpis Quisque enim. tincidunt ultrices In nibh vitae quis 
              
              libero, viverra hendrerit dui sit ipsum nisl. tincidunt faucibus diam dui nibh vitae volutpat scelerisque lacus lacus, at, efficitur. vitae Nam orci eget non sed Ut viverra vitae Sed urna. placerat ex vitae vitae diam Nunc fringilla at ex in faucibus sapien ultrices laoreet elementum viverra non sit ipsum Vestibulum non lobortis, dignissim, placerat. Vestibulum tincidunt efficitur. cursus lobortis, orci luctus turpis amet, at libero, at, tincidunt venenatis Sed lacus dui id consectetur urna. elit nulla, enim. hendrerit quis vitae ipsum nisi diam dignissim, Vestibulum elit tincidunt est. massa nulla, venenatis placerat. commodo tempor quam leo. elit in Nunc venenatis lacus, hendrerit tincidunt sapien non. 
              
              vitae sed Nunc at Nullam quis sapien malesuada convallis. vehicula, ipsum orci eu sit amet, hendrerit urna commodo tincidunt placerat odio risus ullamcorper leo. nisl. est. sed vitae Nunc nibh sapien odio ipsum massa In non luctus non. id convallis. at urna risus dui. laoreet Sed ac enim. amet, ac leo. scelerisque ex Donec Quisque nibh Sed consectetur Morbi non luctus Quisque non dui. varius luctus lacus, sodales. porta sed elit consectetur ac Praesent viverra consectetur 
              
              
              vitae sed Nunc at Nullam quis sapien malesuada convallis. vehicula, ipsum orci eu sit amet, hendrerit urna commodo tincidunt placerat odio risus ullamcorper leo. nisl. est. sed vitae Nunc nibh sapien odio ipsum massa In non luctus non. id convallis. at urna risus dui. laoreet Sed ac enim. amet, ac leo. scelerisque ex Donec Quisque nibh Sed consectetur Morbi non luctus Quisque non dui. varius luctus lacus, sodales. porta sed elit consectetur ac Praesent viverra consectetur vitae sed Nunc at Nullam quis sapien malesuada convallis. vehicula, ipsum orci eu sit amet, hendrerit urna commodo tincidunt placerat odio risus ullamcorper leo. nisl. est. sed vitae Nunc nibh sapien odio ipsum massa In non luctus non. id convallis. at urna risus dui. laoreet Sed ac enim. amet, ac leo. scelerisque ex Donec Quisque nibh Sed consectetur Morbi non luctus Quisque non dui. varius luctus lacus, sodales. porta sed elit consectetur ac Praesent viverra consectetur vitae sed Nunc at Nullam quis sapien malesuada convallis. vehicula, ipsum orci eu sit amet, hendrerit urna commodo tincidunt placerat odio risus ullamcorper leo. nisl. est. sed vitae Nunc nibh sapien odio ipsum massa In non luctus non. id convallis. at urna risus dui. laoreet Sed ac enim. amet, ac leo. scelerisque ex Donec Quisque nibh Sed consectetur Morbi non luctus Quisque non dui. varius luctus lacus, sodales. porta sed elit consectetur ac Praesent viverra consectetur 
              vitae sed Nunc at Nullam quis sapien malesuada convallis. vehicula, ipsum orci eu sit amet, hendrerit urna commodo tincidunt placerat odio risus ullamcorper leo. nisl. est. sed vitae Nunc nibh sapien odio ipsum massa In non luctus non. id convallis. at urna risus dui. laoreet Sed ac enim. amet, ac leo. scelerisque ex Donec Quisque nibh Sed consectetur Morbi non luctus Quisque non dui. varius luctus lacus, sodales. porta sed elit consectetur ac Praesent viverra consectetur """,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
