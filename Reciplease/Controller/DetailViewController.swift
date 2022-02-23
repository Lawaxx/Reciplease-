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
    @IBOutlet weak var getDirectionsButton: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "IngredientsTableViewCell", bundle: nil)
        ingredientTableView.register(nibName, forCellReuseIdentifier: "ingredientsDetailCell")
        
        updateRecipeDetails()
//        ingredientTableView.dataSource = self
//        ingredientTableView.reloadData()
    }
    
     func updateRecipeDetails() {
         guard let image = recipeData?.imageData else { return }
         recipeImageView.image = UIImage(data: image)
         titleLabel.text = recipeData?.title
         ingredientList = recipeData!.ingredients
     }
    @IBAction private func getDirectionsButtonTapped(_ sender: UIButton) {
        print("Tapped Button")
        getDirection()
        }
    
    func getDirection(){
        let url = URL(string: recipeData?.url ?? "www.apple.com")
        guard let recipeURL =  url else { return }
        UIApplication.shared.open(recipeURL)
    }
    
    
}

// MARK: - UITABLEVIEW DATA SOURCE
extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeData?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let ingredientsCell = tableView.dequeueReusableCell(withIdentifier: "ingredientsDetailCell", for: indexPath)
                as? IngredientsTableViewCell else { return UITableViewCell() }
         
        ingredientsCell.textLabel?.textColor = UIColor.white
        ingredientsCell.textLabel?.font = UIFont (name: "Chalkduster", size: 17)
        
        ingredientsCell.textLabel?.text = recipeData?.ingredients[indexPath.row]

        return ingredientsCell
    }
}


// MARK: - UITABLEVIEW DELEGATE
extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
