import 'package:flutter/material.dart';

import '../model/movie.dart';

class MovieListView extends StatelessWidget {

  final List<Movie> movieList = Movie.getMovies();


  final List  movies=[
    "The Shawshank Redemption",
    "The Godfather",
    "The Dark Knight",
    "The Godfather Part II",
    "12 Angry Men",
    "Schindler's List",
    "The Lord of the Rings",
    "Pulp Fiction",
    "Fight Club",
    "Inception",
    "The Matrix",
    "Se7en",
    "intersteller",
    "gone girl",
    "wolfs of wall street",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView.builder(
        shrinkWrap: true,
          itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index) {
          return Stack(
              children:<Widget> [
                movieCard(movieList[index], context),

                Positioned(
                    top: 10.0, left: 3.0,
                    child: movieImage(movieList[index].images[0]))
              ]);
      }),
    );
  }

  Widget movieCard(Movie movie , BuildContext context){
    return InkWell(
      child : Container(
        margin: EdgeInsets.only(left: 60.0),
        width: MediaQuery.of(context).size.width,
        height: 120.0,
        child: Card(
          color: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.only(top:8.0, bottom: 8.0 , left: 55.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget> [

                          Flexible(
                            child: Text(movie.title, style:TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,

                            ),),
                          ),
                          Text("Rating: ${movie.imdbID}/10.0",style: mainTextStyle(),)

                      ],),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text("Realesed: ${movie.released}",style: mainTextStyle()),
                          Text(movie.runtime,style: mainTextStyle(),),
                          Text(movie.rated,style: mainTextStyle())
                        ],
                      )

                    ],

        ),
                ),
              )
        ),
      ),
    onTap: (){
           Navigator.push(context, MaterialPageRoute(
               builder: (context)=> MovieListViewDetails(movieName:movie.title , movie: movie)));
       },
    );
  }

  TextStyle mainTextStyle(){
    return TextStyle(
          fontSize: 15.0,
          color: Colors.blueGrey
    );
  }

  Widget movieImage(String imageUrl){
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(imageUrl ??"" ),
            fit: BoxFit.cover
          )
      ),
    );
  }
}
// new route (screen or page)
class MovieListViewDetails extends StatelessWidget {
  final String movieName;
  final Movie movie;
  const MovieListViewDetails({super.key, required this.movieName , required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies "),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      
    body:ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
          MovieDetailsTumbnails(thumbnail: movie.images[0],),
          MovieDetailsHeaderWithPoster(movie: movie),
          HorizonalLine(),
          MovieDeatailsCast(movie: movie),
          HorizonalLine(),
          MovieDeatailsExtraPosters(posters: movie.images)

        ],
      ),
    );
  }
}
class  MovieDetailsTumbnails extends StatelessWidget {
  final String thumbnail;

  const MovieDetailsTumbnails({super.key, required this.thumbnail});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(thumbnail),
                  fit: BoxFit.fill),
              ),
            ),
            
            Icon(Icons.play_circle_outline, size: 100,
              color: Colors.white)
            
          ],
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0x00f5f5f5),Color(0xfff5f5f5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter)
          ),
          height:100,
        )

      ],
    );
  }
}

class  MovieDetailsHeaderWithPoster extends StatelessWidget {
  final Movie movie;

  const MovieDetailsHeaderWithPoster ({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        
        children: <Widget>[
          MoviePoster (poster:movie.images[0].toString()),
          SizedBox(width: 16,),
          Expanded(child: MovieDetailsHeader(movie:movie))

        ],
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  final String poster;


  const MoviePoster ({required this.poster});

  @override
  Widget build(BuildContext context) {
    var  borderRadius = BorderRadius.all(Radius.circular(10));
    return Card(
      child: ClipRRect(
        borderRadius:  borderRadius,
        child: Container(
            width: MediaQuery.of(context).size.width/4,
          height: 160,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(poster),
            fit: BoxFit.cover)
          ),
        ),
      ),
    );
  }
}

class MovieDetailsHeader extends StatelessWidget {
  final Movie movie;
  const MovieDetailsHeader({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("${movie.year} . ${movie.genre}".toUpperCase(),style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.cyan
        ),),
        Text(movie.title, style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 32
        ),),
        Text.rich(TextSpan(style : TextStyle(
            fontSize: 13, fontWeight: FontWeight.w400,
        ),
          children: <TextSpan>[
            TextSpan(
              text: movie.plot
            ),
            TextSpan(
                text: "More...",
                style : TextStyle(
                  color:Colors.indigoAccent
                )
            )
          ]
        ))
      ],
    );
  }
}

class MovieDeatailsCast extends StatelessWidget {
  final Movie movie;


  const MovieDeatailsCast({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: <Widget>[
          MovieField(field: "Cast", value: movie.actors),
          MovieField(field: "Directors", value: movie.director),
          MovieField(field: "Awards", value: movie.awards)

        ],


      ),
    );
  }
}

class MovieField extends StatelessWidget {
  final String field , value;

  MovieField({required this.field,required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("$field : ",style: TextStyle(
          color: Colors.black38,
          fontSize: 14,
          fontWeight: FontWeight.w400
        ),),
        Expanded(
          child: Text(value, style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400
          ),),
        )
      ],
    );
  }
}
class HorizonalLine extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 6),
      child: Container(
        height: 0.5,
        color: Colors.grey,
      ),
    );
  }
}

class MovieDeatailsExtraPosters extends StatelessWidget {
  final List <String> posters;

  MovieDeatailsExtraPosters({required this.posters});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("More Movie Posters".toUpperCase(),
        style: TextStyle(
          fontSize: 14,
          color: Colors.black26
        ),),
        Container(
          height:200 ,
          child: ListView.separated(

            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 8,),
            itemCount: posters.length,
            itemBuilder:(context,index) => ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(

                width: MediaQuery.of(context).size.width/4,
                height: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(posters[index]),fit: BoxFit.cover)
                ),
              ),
    ),),

        )
        
      ],
    );
  }
}
