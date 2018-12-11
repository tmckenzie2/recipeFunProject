//
//  RecipeTableViewCell.swift
//  recipefun
//
//  Created by McKenzie, Thomas Patrick on 12/8/18.
//  Copyright © 2018 Daniel Richard. All rights reserved.
//

import UIKit
import CoreData

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadImage (imageURL: String){
        let url = URL(string:imageURL)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.recipeImageView.image = UIImage(data: data!)
            }
        }
    }
    
    func update(with recipe: Recipe) {
        loadImage(imageURL: recipe.mealThumb)
        
        nameLabel.text = recipe.meal
        }
}
