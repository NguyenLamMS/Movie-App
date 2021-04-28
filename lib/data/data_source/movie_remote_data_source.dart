
import 'package:movieapp/data/core/api_client.dart';
import 'package:movieapp/data/models/cast_crew_result_data_model.dart';
import 'package:movieapp/data/models/movie_detail_model.dart';
import 'package:movieapp/data/models/movie_model.dart';
import 'package:movieapp/data/models/movie_result_model.dart';
import 'package:movieapp/data/models/search_model.dart';
import 'package:movieapp/data/models/search_result_model.dart';
import 'package:movieapp/data/models/video_model.dart';
import 'package:movieapp/data/models/video_result_model.dart';

import '../models/movie_result_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrending();
  Future<List<MovieModel>> getPopular();
  Future<List<MovieModel>> getPlayingNow();
  Future<List<MovieModel>> getComingSoon();
  Future<MovieDetailModel> getMovieDetail(int id);
  Future<List<CastModel>> getCastCrew(int id);
  Future<List<VideoModel>> getVideo(int id);
  Future<List<SearchModel>> searchVideo(String searchValue);
}
class MovieRemoteDataSourceImpl extends MovieRemoteDataSource{
  final ApiClient _client;

  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<List<MovieModel>> getTrending() async {
    final response = await _client.get('trending/movie/day');
    return MoviesResultModel.fromJson(response).movies;
  }

  @override
  Future<List<MovieModel>> getPopular() async {
    final response = await _client.get('movie/popular');
    return MoviesResultModel.fromJson(response).movies;
  }

  @override
  Future<List<MovieModel>> getComingSoon() async {
    final response = await _client.get('movie/upcoming');
    return MoviesResultModel.fromJson(response).movies;
  }

  @override
  Future<List<MovieModel>> getPlayingNow() async {
    final response = await _client.get('movie/now_playing');
    return MoviesResultModel.fromJson(response).movies;
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    final response = await _client.get('movie/$id');
    final movie = MovieDetailModel.fromJson(response);
    return movie;
  }

  @override
  Future<List<CastModel>> getCastCrew(int id) async {
    final response = await _client.get('movie/$id/credits');
    final cast = CastCrewResultModel.fromJson(response).cast;
    return cast;
  }

  @override
  Future<List<VideoModel>> getVideo(int id) async {
    final response = await _client.get('movie/$id/videos');
    final video = VideoResultModel.fromJson(response).videos;
    return video;
  }

  @override
  Future<List<SearchModel>> searchVideo(String searchValue) async {
    Map<String, String> params = {
      'query': searchValue
    };
    final response = await _client.get('search/movie', params: params);
    final movies = SearchResultModel.fromJson(response).movies;
    return movies;
  }
}

