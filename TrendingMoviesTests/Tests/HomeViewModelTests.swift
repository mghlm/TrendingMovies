//
//  HomeViewModelTests.swift
//  TrendingMoviesTests
//
//  Created by Magnus Holm on 06/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import XCTest
import CoreData
@testable import TrendingMovies

class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModelType!
    var apiService: APIServiceMock!
    var persistenceService: PersistenceServiceType!
    
    var contextMock: NSManagedObjectContext!
    
    override func setUp() {
        apiService = APIServiceMock()
        contextMock = CoreDataHelpers().contextMock
        persistenceService = PersistenceService(context: contextMock)
        viewModel = HomeViewModel(dataSource: HomeScreenDataSource(), apiService: apiService, persistenceService: persistenceService)
    }
    
    func testDatasourceSetup() {
        XCTAssertNotNil(viewModel.dataSource)
    }
    
    func testFetchMoviesFromStorage() {
        insertMovies()
        let fetchedMovies = fetchMovies()
        XCTAssertTrue(fetchedMovies.count == 3, "Wrong number of movies: \(fetchedMovies.count). Should be 3.")
    }
    
    func testFetchMoviesFromApiSuccess() {
        let expectation = self.expectation(description: "Movies")
        apiService.result = .success
        apiService.request(endpoint: .getTrendingMovies(page: "1")) { result in
            expectation.fulfill()
            switch result {
            case .success(let movieResult):
                self.wait(for: [expectation], timeout: 1)
                guard let movies = movieResult["results"] as? JSON else { return }
                XCTAssertEqual(movies.count, 1)
                XCTAssertEqual(movies["id"] as! Int, 123)
                XCTAssertEqual(movies["original_language"] as! String, "en")
                XCTAssertEqual(movies["original_title"] as! String, "Interstellar")
                XCTAssertEqual(movies["overview"] as! String, "Space stuff")
                XCTAssertEqual(movies["popularity"] as! Double, 999.999)
                XCTAssertEqual(movies["poster_path"] as! String, "https://imgur.com/123.jpg")
                XCTAssertEqual(movies["release_date"] as! String, "21.12.2009")
                XCTAssertEqual(movies["title"] as! String, "Interstellar")
                XCTAssertEqual(movies["vote_average"] as! Double, 9.9)
                XCTAssertEqual(movies["vote_count"] as! Int, 123)
                
            case .failure(let error):
                XCTFail("\(error.rawValue) not expected")
            }
        }
    }
    
    func testFetchingMoviesFromApiFailure() {
        apiService.result = .networkError
        apiService.request(endpoint: .getTrendingMovies(page: "1")) { result in
            switch result {
            case .success(let movieResponse):
                XCTFail("\(movieResponse) not expected")
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.networkError)
            }
        }
    }
    
    // MARK: - Private methods
    
    private func insertMovies() {
        guard let entity = NSEntityDescription.entity(forEntityName: "Movie", in: self.contextMock) else { return }
        for _ in 0...2 {
            let movie = Movie.init(entity: entity, insertInto: self.contextMock)
            movie.id = 123
            movie.originalLanguage = "en"
            movie.originalTitle = "Interstellar"
            movie.overview = "Space stuff"
            movie.popularity = 999.999
            movie.posterPath = "https://imgur.com/123.jpg"
            movie.releaseDate = "21.12.2009"
            movie.title = "Interstellar"
            movie.voteAverage = 9.9
            movie.voteCount = 123
        }
    }
    
    private func fetchMovies() -> [Movie] {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        let results = try! contextMock.fetch(request)
        return results
    }
}
