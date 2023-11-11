import 'package:flutter/material.dart';

class BlogDetailsPage extends StatelessWidget {

  String imageUrl;
  String blogTitle;
  String blogTag;
  String blogDate;
  String blogDescription;

  BlogDetailsPage({super.key,
    required this.imageUrl,
    required this.blogTitle,
    required this.blogTag,
    required this.blogDate,
    required this.blogDescription
  });

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Image
              Container(
                height: size.height*0.2,
                width: size.width,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(imageUrl),
                    )
                ),
              ),
              const SizedBox(height: 10,),

              //Title
              Text(
                blogTitle,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10,),

              //Tags
              Text(
                  blogTag,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.lightBlue,
                  )
              ),
              const SizedBox(height: 10,),

              //Date of the post
              Text(
                blogDate,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),


              //Description
              Text(
                  blogDescription,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  )
              ),
              const SizedBox(height: 10,),

            ],
          ),
        ),
      ),
    );
  }
}
