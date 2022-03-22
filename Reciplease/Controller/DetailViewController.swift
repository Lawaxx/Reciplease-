//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Aurelien Waxin on 28/01/2022.
//

import UIKit


final class DetailViewController: UIViewController {
    
    //    MARK: - Properties
    
    var ingredientList = [String]()
    var recipeResponse : EdamamResponse?
    var recipeEntity : RecipeEntity?
    var recipeDetail : RecipeDetail?
    var coreDataManager : CoreDataManager?
    var recipeIsFavorite = false
    
    //    MARK: - Outlets
    
    @IBOutlet private var recipeImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var gradientView: UIView!
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var addFavoriteButtonBar: UIBarButtonItem!
    
    
    //    MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataFunction()
        
        updateRecipeDetails()
        //        ingredientTableView.dataSource = self
        //        ingredientTableView.delegate = self
        ingredientTableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfRecipeIsFavorite()
    }
    
    func updateRecipeDetails() {
        guard let image = recipeDetail?.imageData else { return }
        recipeImageView.image = UIImage(data: image)
        titleLabel.text = recipeDetail?.title
        
    }
    
    private func coreDataFunction() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    func checkIfRecipeIsFavorite() {
        guard let recipeTitle = recipeDetail?.title else { return }
        guard let url = recipeDetail?.url else { return }
        guard let checkIsRecipeIsFavorite = coreDataManager?.checkIfRecipeIsFavorite(recipeTitle: recipeTitle, url: url) else { return }
        
        recipeIsFavorite = checkIsRecipeIsFavorite
        
        if recipeIsFavorite == true {
            addFavoriteButtonBar.tintColor = UIColor.green
        } else {
            addFavoriteButtonBar.tintColor = .none
        }
    }
    
    func getDirection() {
        guard let url = URL(string: recipeDetail?.url ?? "") else {
            return presentSafariAlert()
        }
        UIApplication.shared.open(url)
    }
    
    //    MARK: - Actions
    
    @IBAction private func getDirectionsButtonTapped(_ sender: UIButton) {
        print("Tapped Button")
        getDirection()
    }
    
    @IBAction func addToFavorite(_ sender: Any) {
        print("addFavoriteButtonTaped")
        checkIfRecipeIsFavorite()
        guard let label = recipeDetail?.title else { return }
        guard let ingredients = recipeDetail?.ingredients else { return }
        guard let yield = recipeDetail?.yield else { return }
        let totalTime = recipeDetail?.totalTime ?? ""
        guard let image = recipeDetail?.imageData else { return }
        guard let url = recipeDetail?.url else { return }
        
        coreDataManager?.createRecipe(title: label, ingredients: ingredients, yield: yield, totalTime: totalTime, image: image, url: url)
        
        addFavoriteButtonBar.tintColor = UIColor.green
        print(coreDataManager?.recipes ?? "choux")
        if recipeIsFavorite == true {
            coreDataManager?.deleteRecipe(recipeTitle: label, url: url)
            addFavoriteButtonBar.tintColor = .none
        }
    }
}

// MARK: - UITABLEVIEW DATA SOURCE
extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDetail?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let ingredientsCell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath)
        //                as? IngredientsTableView else { return UITableViewCell() }
        
        ingredientsCell.textLabel?.textColor = UIColor.white
        ingredientsCell.textLabel?.font = UIFont (name: "Chalkduster", size: 17)
        
        ingredientsCell.textLabel?.text = "- " + (recipeDetail?.ingredients[indexPath.row])!
        
        return ingredientsCell
    }
}


// MARK: - UITABLEVIEW DELEGATE
extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
