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
    
    func configure(withIngredient ingredient: String) {
            ingredientsDetailLabel?.text = "- " + ingredient.localizedCapitalized
        }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
