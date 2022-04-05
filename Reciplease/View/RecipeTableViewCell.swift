//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Aurelien Waxin on 14/02/2022.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeSubtitle: UILabel!
    @IBOutlet weak var recipeYieldLabel: UILabel!
    @IBOutlet weak var recipeTotalTimeLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var setRecipe: Hit? {
        didSet {
            guard let imageUrl = URL(string: setRecipe?.recipe?.image ?? "recipeImage") else { return }
            recipeImage.getImage(with: imageUrl)
            recipeTitle.text = setRecipe?.recipe?.label
            recipeSubtitle.text = setRecipe?.recipe?.ingredientLines?[0]
            recipeTotalTimeLabel.text = setRecipe?.recipe?.totalTime?.formatted()
            recipeYieldLabel.text = setRecipe?.recipe?.yield?.formatted()
        }
    }
    var setFavorite: RecipeEntity? {
        didSet {
            guard let imageUrl = URL(string: setFavorite?.imageData?.base64EncodedString() ?? "recipeImage") else {return}
            recipeImage.getImage(with: imageUrl)
            recipeTitle.text = setFavorite?.title
            recipeSubtitle.text = setFavorite?.ingredients?.joined(separator: "\n" + "- ")
            recipeTotalTimeLabel.text = setFavorite?.totalTime
            recipeYieldLabel.text = setFavorite?.yield
        }
    }
}
