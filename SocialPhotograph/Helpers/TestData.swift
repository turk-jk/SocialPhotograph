//
//  TestData.swift
//  SocialPhotograph
//
//  Created by yacob kazal on 16/10/2023.
//

import Foundation
protocol TestDataFileProtocol {
    /// Fully qualified path for the test data file.
    var path: String? { get }
}

struct TestData {}

extension TestData {
    enum TestDataFile: String, TestDataFileProtocol, CaseIterable{
        case defaultLocations
        var path: String? {
            Bundle.main.path(forResource: rawValue, ofType: "json")
        }
    }
    
    /// Data object for a fully qualified path. Fatal error if cannot load data.
    static func dataFromFile(path: String) -> Data {
        guard let fileData = FileManager.default.contents(atPath: path) else {
            fatalError("Connot load data from file")
        }
        return fileData
    }

    /// Decodable object from the specified file. Fatal error if cannot load data.
    static func dataFromFile<T>(file: TestDataFile) -> T where T: Decodable {
        dataFromFile(path: file.path!)
    }

    /// Decodable object for a fully qualified path. Fatal error if cannot load data.
    static func dataFromFile<T: Decodable>(path: String) -> T {
        modelFromData(dataFromFile(path: path))
    }

    /// Decodable object for a Data. Fatal error if cannot load data.
    static func modelFromData<T: Decodable>(_ data: Data) -> T {
        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            return model
        } catch let error as NSError {
            fatalError("Cannot decode data with error, \(error.userInfo)")
        }
    }
}
