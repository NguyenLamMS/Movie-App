import 'package:movieapp/data/models/movie_model.dart';

class MoviesResultModel{
    final List<MovieModel> movies;

  MoviesResultModel({this.movies});

  factory MoviesResultModel.fromJson(Map<String, dynamic> json){
    List tempMovies = new List<MovieModel>();
    if(json['results'] != null){
      json['results'].forEach((v){
        tempMovies.add(MovieModel.fromJson(v));
      });
    }
    return MoviesResultModel(movies: tempMovies);
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.movies != null){
      data['result'] = this.movies.map((e) => e.toJson()).toList();
    }
    return data;
  }

}