//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Aurelien Waxin on 28/01/2022.
//

import UIKit

final class DetailViewController: UIViewController {
    
    var ingredientList = [String]()
    var recipeResponse : EdamamResponse?
    var recipeData : RecipeData?
    var recipe : Recipe?
    
    @IBOutlet private var recipeImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var gradientView: UIView!
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var ingredientsCell: UITableViewCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "IngredientsTableViewCell", bundle: nil)
        ingredientTableView.register(nibName, forCellReuseIdentifier: "ingredientsCell")
        updateRecipeDetails()
        ingredientTableView.reloadData()
    }
     func updateRecipeDetails() {
         guard let image = recipeData?.imageData else { return }
         recipeImageView.image = UIImage(data: image)
         titleLabel.text = recipeData?.title
//         ingredientList = recipeData!.ingredients
//         ingredientsCell = recipeData?.ingredients
     }
}


// MARK: - UITABLEVIEW DATA SOURCE
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe?.ingredientLines.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsDetailCell", for: indexPath) as? IngredientsTableViewCell else {
        
//        guard let ingredient = recipeData?.ingredients else {
            return UITableViewCell()
        }
//        guard let ingredient = recipeData?.ingredients else {
//            return UITableViewCell()
//        }
//        cell.textLabel?.text =  ingredient.joined(separator: ",\n - ")
        return cell
      }
   }

//UIListContentConfiguration.TextProperties = Ingredient
