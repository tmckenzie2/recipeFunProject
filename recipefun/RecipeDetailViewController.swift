//
//  RecipeDetailViewController.swift
//  recipefun
//
//  Created by McKenzie, Thomas Patrick on 12/8/18.
//  Copyright © 2018 Daniel Richard. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe? = nil
   
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    
    @IBOutlet weak var recipeTextView: UITextView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var mealLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        updateView()
        
        loadImage(imageURL: (recipe?.mealThumb)!)
        if let recipe = recipe{
            categoryLabel.text = recipe.category
            areaLabel.text = recipe.area
            mealLabel.text = recipe.meal
            
                        
        }

        // Do any additional setup after loading the view.
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
        recipeTextView.text = recipe?.instructions
        
    }
    
    func loadImage (imageURL: String){
        let url = URL(string: imageURL)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.recipeImageView.image = UIImage(data: data!)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "showVideoSegue"){
            let websiteController = segue.destination as! ViewController
            websiteController.videoCode = recipe?.youTubeUrl
        }}
    
   
}
