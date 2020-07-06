import 'package:flutter/material.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/model/article_model.dart';

import 'article_view.dart';
class CategoryNews extends StatefulWidget {
  final String category;

  const CategoryNews({Key key, this.category}) : super(key: key);

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {

  List<ArticleModel> article=new List<ArticleModel>();
  bool _loading=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getcatNews();
  }
  getcatNews()async{
    CategoryNewsClass newsClass=CategoryNewsClass();
    await newsClass.getcatNews(widget.category);
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
      body:_loading? Center(
        child: Container(
          child:CircularProgressIndicator() ,
        ),
      ):
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
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
