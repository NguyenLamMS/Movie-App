import 'package:movieapp/data/models/search_model.dart';

class SearchResultModel {
  int page;
  List<SearchModel> movies;
  int totalPages;
  int totalResults;
  SearchResultModel({this.page, this.movies, this.totalPages, this.totalResults});
  SearchResultModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      movies = new List<SearchModel>();
      json['results'].forEach((v) {
        movies.add(new SearchModel.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.movies != null) {
      data['results'] = this.movies.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }
}