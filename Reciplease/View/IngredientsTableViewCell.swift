//
//  IngredientsTableViewCell.swift
//  Reciplease
//
//  Created by Aurelien Waxin on 17/02/2022.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var ingredientsDetailLabel: UILabel!
    
//    func setIngredients(withIngredient ingredient: String) {
//        ingredientsDetailLabel.text = ingredient
//        }
    
//    var setIngredients: Ingredient? {
//        didSet {
//            guard let imageUrl = URL(string: setRecipe?.recipe.image ?? "recipeImage") else { return }
//            ingredientsDetailLabel.text = setIngredients?.text
//            recipe.ingredientLines.joined()
//            recipeImage.getImage(with: imageUrl)
//            recipeTitle.text = setRecipe?.recipe.label
//            recipeSubtitle.text = setRecipe?.recipe.ingredientLines[0]
//        }
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
