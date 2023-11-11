import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_health_care/controller/Blog_Controller/blog_controller.dart';
import 'package:intl/intl.dart';
import 'package:patient_health_care/view/screens/Blog_Page/Blog_Details_Page/blog_details_page.dart';



class BlogPage extends StatefulWidget {
   const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {

  @override
  void initState() {
    Get.put(BlogController());
    Get.find<BlogController>().fetchBlogDetails();
    super.initState();
  }

  // BlogController myBlogController = Get.put(BlogController());

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text("Read something health related"),),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GetBuilder<BlogController>(
          builder: (myBlogController){
            return myBlogController.isLoading ?
            const Center(child: CircularProgressIndicator()) :
            ListView.builder(
                shrinkWrap: true,
                itemCount: myBlogController.blogList[0].blog!.length,
                itemBuilder: (context, index){
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
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
                                    image: NetworkImage("${myBlogController.imagebaseUrl}${myBlogController.blogList[0].blog![index].image}"),
                                  )
                              ),
                            ),
                            const SizedBox(height: 10,),

                            //Title
                            Text(
                                myBlogController.blogList[0].blog![index].title ?? "",
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10,),

                            //Tags
                            Text(
                                myBlogController.blogList[0].blog![index].tags ?? "",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.lightBlue,
                                )
                            ),
                            const SizedBox(height: 10,),

                            //Date of the post
                            Text(
                              myBlogController.blogList[0].blog![index].createdAt != null
                                  ? DateFormat('yyyy-MM-dd').format(myBlogController.blogList[0].blog![index].createdAt!).toString()
                                  : "",
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),


                            //Description
                            Text(
                                myBlogController.blogList[0].blog![index].description ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                )
                            ),
                            const SizedBox(height: 10,),

                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //See more button
                            ElevatedButton(
                              onPressed: (){
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) => BlogDetailsPage(
                                            imageUrl: "${myBlogController.imagebaseUrl}${myBlogController.blogList[0].blog![index].image}",
                                            blogTitle: myBlogController.blogList[0].blog![index].title ?? "",
                                            blogTag: myBlogController.blogList[0].blog![index].tags ?? "",
                                            blogDate: myBlogController.blogList[0].blog![index].createdAt != null
                                                ? DateFormat('yyyy-MM-dd').format(myBlogController.blogList[0].blog![index].createdAt!).toString()
                                                : "",
                                            blogDescription: myBlogController.blogList[0].blog![index].description ?? ""
                                        ),
                                    )
                                );
                              },
                              style:  ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                              ),
                              child: const Text(
                                "See more",
                                style: TextStyle(color: Colors.white, fontSize: 15),
                              ),
                            ),

                            //Visited by text
                            Text(
                                "Visited by : ${myBlogController.blogList[0].blog![index].visits}",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.blueGrey
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }
            );
          },
        ),
      ),
    );
  }
}
