//
//  AddRecipeViewController.swift
//  recipefun
//
//  Created by McKenzie, Thomas Patrick on 12/8/18.
//  Copyright © 2018 Daniel Richard. All rights reserved.
//

import UIKit

class AddRecipeViewController: UIViewController {
    var recipe: Recipe? = nil

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipe = getRecipe()
        updateView()
        print(recipe?.mealThumb)
        loadImage(imageURL: (recipe?.mealThumb)!)
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var mealLabel: UILabel!
    
    @IBOutlet weak var instructionsView: UITextView!
    @IBAction func saveButton(_ sender: Any) {
    }
    @IBAction func viewVideoButton(_ sender: Any) {
       
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func updateView() {
        areaLabel.text = recipe?.area
        categoryLabel.text = recipe?.category
        mealLabel.text = recipe?.meal
        instructionsView.text = recipe?.instructions

    }
    
    func loadImage (imageURL: String){
        let url = URL(string: imageURL)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data!)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "showVideoSegue"){
            let websiteController = segue.destination as! ViewController
            websiteController.videoCode = recipe?.youTubeUrl
        }
        
        
        
        
    }
    
    func getRecipe() -> Recipe{
            
            
            let url = URL(string: "https://www.themealdb.com/api/json/v1/1/random.php")!
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            var recipe = Recipe(meal: "", mealThumb: "", category: "", instructions: "", youTubeUrl: "", area: "", mealID: "")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(error)")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                }
                
                
                let responseString = String(data: data, encoding: .utf8)
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                var dict = json as! NSDictionary
                
                let meal = dict["meals"] as! NSArray
                let item = meal[0] as! NSDictionary
                
                recipe.area = item["strArea"] as! String
                recipe.category = item["strCategory"] as! String
                recipe.mealID = item["idMeal"] as! String
                recipe.instructions = item["strInstructions"] as! String
                recipe.meal = item["strMeal"] as! String
                recipe.mealThumb = item["strMealThumb"] as! String
                recipe.youTubeUrl = item["strYoutube"] as! String
                
            }
            task.resume()
            sleep(1)
            print(recipe)
            return recipe
            
            
        }
        
    }
    

