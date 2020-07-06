import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/helper/data.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/model/article_model.dart';
import 'package:newsapp/model/category_model.dart';
import 'package:newsapp/views/article_view.dart';
import 'package:newsapp/views/category_news.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories=new List<CategoryModel>();
  List<ArticleModel> article=new List<ArticleModel>();
  bool _loading=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories=getCategories();
    getNews();
  }
  getNews()async{
    News newsClass=News();
    await newsClass.getNews();
    article=newsClass.news;
    setState(() {
      _loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Flutter'),
            Text('News',style: TextStyle(
              color: Colors.blue,
            ),)
          ],
        ),
      ),
      body: _loading? Center(
        child: Container(
        child:CircularProgressIndicator() ,
        ),
      ):SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children:<Widget> [
              ///Categories
              Container(
                height: 70,

                child: ListView.builder(
                  itemCount: categories.length,
                    shrinkWrap: true,
                   scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                    return CategoryTile(
                      imageurl: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,
                    );
                    }
                ),
              ),
              ///Blogs
              Container(
                height: MediaQuery.of(context).size.height-160,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  itemCount: article.length,
                   scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                    return BlogTile(
                      imageUrl: article[index].urlToImage,
                      title: article[index].title,
                      desc: article[index].description,
                      url: article[index].url,
                    );
                    }
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class CategoryTile extends StatelessWidget {
  final String imageurl;
  final String categoryName;

  const CategoryTile({Key key, this.imageurl, this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryNews(category: categoryName.toLowerCase(),)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(imageUrl: imageurl,width: 120,height: 60,fit: BoxFit.cover,)),
            Container(
              width: 120,height: 60,
           alignment: Alignment.center,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(6),
             color: Colors.black26,
             ),
              child: Text(categoryName,style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500

              ),),
            )
          ],
        ),
      ),
    );
  }
}
class BlogTile extends StatelessWidget {
  final String imageUrl,title,desc,url;

  const BlogTile({Key key, this.imageUrl, this.title, this.desc, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticleView(imageUrl: url)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children:<Widget> [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl)),
            SizedBox(height: 8,),
            Text(title,style: TextStyle(
              fontSize: 17,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),),
            SizedBox(height: 8,),
            Text(desc,style: TextStyle(
              color: Colors.black54,
            ),),
          ],
        ),
      ),
    );
  }
}

