//
//  Recipe.swift
//  recipefun
//
//  Created by McKenzie, Thomas Patrick on 12/8/18.
//  Copyright © 2018 Daniel Richard. All rights reserved.
//

import Foundation
import CoreData

class Recipe: Codable{

    var area: String
    var category: String
    var instructions: String
    var meal: String
    var mealThumb: String
    var youTubeUrl: String
    var mealID: String


    init(meal: String, mealThumb:String, category:String, instructions: String, youTubeUrl: String, area: String, mealID: String){
    self.meal = meal
    self.mealThumb = mealThumb
    self.instructions = instructions
        self.category = category
        self.youTubeUrl = youTubeUrl
        self.area = area
        self.mealID = mealID
    }
    
    
    static let recipePListURL: URL = {
        // this is called an initialization closure
        // get a URL to the documents directory
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // .userDomainMask refers to the user's home directory
        let fileURL = documentsDirectory.appendingPathComponent("recipes").appendingPathExtension("plist")
        return fileURL
    }()
    
    static func saveToFile(recipes: [Recipe]) {
        let plistEncoder = PropertyListEncoder()
        
        if let recipesData = try? plistEncoder.encode(recipes) {
            // Data is a byte representation
            // that we can use to write and read to/from disk
            try? recipesData.write(to: recipePListURL)
        }
    }
    
    static func loadFromFile() -> [Recipe]? {
        let plistDecoder = PropertyListDecoder()
        
        if let recipesData = try? Data(contentsOf: recipePListURL), let decodedRecipes = try? plistDecoder.decode([Recipe].self, from: recipesData) {
            return decodedRecipes
        }
        return nil
    }
}
