//
//  PersistenceService.swift
//  TrendingMovies
//
//  Created by Magnus Holm on 07/08/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import Foundation
import CoreData

protocol PersistenceServiceType {
    
    /// Removes all instances of Movie, and inserts a new array of JSON into storage.
    ///
    /// - Parameters:
    ///   - movies: Array of movie objects as JSON
    ///   - completion: After insertion is finished
    func insertMoviesInCoreData(movies: [JSON], completion: @escaping () -> Void)
    
    /// Fetches all NSManagedObjects of type T
    ///
    /// - Parameters:
    ///   - type: Generic type of NSManagedObject
    ///   - completion: An array of all specified NSManagedObjects
    func fetch<T: NSManagedObject>(_ type: T.Type, completion: @escaping ([T]) -> Void)
    
    /// Creastes and adds image data for Movie object and saves updated object to storage
    func addImageDataToMovies()
}

final class PersistenceService: PersistenceServiceType {
    
    // MARK: - Private properties
    
    private var context: NSManagedObjectContext!
    
    // MARK: - Init
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Public methods 
    
    func insertMoviesInCoreData(movies: [JSON], completion: @escaping () -> Void) {
        removeAll(Movie.self)
        _ = movies.map { self.createMovieEntityFrom(json: $0) }
        do {
            try context.save()
            completion()
        } catch let error as NSError {
            print("Could not insert. \(error), \(error.userInfo)")
        }
    }
    
    func fetch<T: NSManagedObject>(_ type: T.Type, completion: @escaping ([T]) -> Void) {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        
        do {
            let objects = try context.fetch(request)
            completion(objects)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)") 
            completion([])
        }
    }
    
    func addImageDataToMovies() {
        let request = NSFetchRequest<Movie>(entityName: String(describing: Movie.self))
        let movies = try! context.fetch(request)
        movies.forEach {
            guard let posterPath = $0.posterPath else { return }
            
            if let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
                do {
                    let data = try Data(contentsOf: imageUrl)
                    $0.image = data
                    try context.save()
                } catch {
                    print("Not able to create image data") 
                }
            }
        }
    }
    
    // MARK: - Private methods
    
    private func removeAll<T: NSManagedObject>(_ type: T.Type) {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        
        do {
            let results = try context.fetch(request)
            results.forEach { context.delete($0) }
            try context.save()
        } catch {
            print(error)
        }
    }
    
    private func createMovieEntityFrom(json: JSON) -> NSManagedObject? {
        if let movieEntity = NSEntityDescription.insertNewObject(forEntityName: "Movie", into: context) as? Movie {
            guard
                let id = json["id"] as? Int32,
                let originalLanguage = json["original_language"] as? String,
                let originalTitle = json["original_title"] as? String,
                let overview = json["overview"] as? String,
                let popularity = json["popularity"] as? Double,
                let posterPath = json["poster_path"] as? String,
                let releaseDate = json["release_date"] as? String,
                let title = json["title"] as? String,
                let voteAverage = json["vote_average"] as? Double,
                let voteCount = json["vote_count"] as? Int32
                else { return nil }
            
            movieEntity.id = id
            movieEntity.originalLanguage = originalLanguage
            movieEntity.originalTitle = originalTitle
            movieEntity.overview = overview
            movieEntity.popularity = popularity
            movieEntity.posterPath = posterPath
            movieEntity.releaseDate = releaseDate
            movieEntity.title = title
            movieEntity.voteAverage = voteAverage
            movieEntity.voteCount = voteCount
            return movieEntity
        }
        return nil 
    }
}

