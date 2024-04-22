import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:movies/features/movies/domain/entities/movie.dart';
import 'package:movies/features/movies/domain/usecases/get_trending_movies.dart';
import 'package:movies/features/movies/domain/repository/movie_repository.dart';

import 'get_trending_movies_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRepository>()])
void main() {
  late GetTrendingMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetTrendingMovies(mockMovieRepository);
  });

  final tMovieList = [
    Movie(
        id: 1,
        title: 'Movie 1',
        overview: 'Overview 1',
        posterPath: 'posterPath 1'),
    Movie(
        id: 2,
        title: 'Movie 2',
        overview: 'Overview 2',
        posterPath: 'posterPath 2'),
  ];

  test('should get trending moviews from the repository', () async {
    // Arrange
    when(mockMovieRepository.getTrendingMovies())
        .thenAnswer((_) async => tMovieList);

    // Act
    final result = await usecase();

    // Assert
    expect(result, equals(Right(tMovieList)));
    verify(mockMovieRepository.getTrendingMovies());
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
