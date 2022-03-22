//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Aurelien Waxin on 25/02/2022.
//

import UIKit

final class FavoriteViewController : UIViewController {
    
    // MARK: - Properties
    
    var recipeEntity : RecipeEntity?
    var recipeResponse : EdamamResponse?
    var coreDataManager : CoreDataManager?
    var recipeDetail : RecipeDetail?
    
    //    MARK: - Outlets
    
    @IBOutlet weak var favoriteTableView : UITableView!
    
    //    MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataFunction()
        
        let nibName = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        favoriteTableView.register(nibName, forCellReuseIdentifier: "RecipeCell")
        
        print(coreDataManager?.recipes ?? "choux")
        favoriteTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipeVC = segue.destination as? DetailViewController else { return }
        recipeVC.recipeDetail = recipeDetail
    }
    
    private func coreDataFunction() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
}


// MARK: - UITableViewDataSource
extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.recipes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let favoriteCell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        
        let recipe = coreDataManager?.recipes[indexPath.row]
        favoriteCell.recipeTitle.text = recipe?.title
        favoriteCell.recipeSubtitle.text = recipe?.ingredients?.joined(separator: ", ")
        favoriteCell.recipeImage.image = UIImage(data: (recipe?.imageData)!)
        favoriteCell.recipeYieldLabel.text = recipe?.yield
        favoriteCell.recipeTotalTimeLabel.text = recipe?.totalTime
        return favoriteCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let recipe = coreDataManager?.recipes[indexPath.row]
        if editingStyle == .delete {
            print("Deleted")
            recipe?.managedObjectContext?.delete(recipe!)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - UITableViewDelegate
extension FavoriteViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.recipeEntity = coreDataManager?.recipes[indexPath.row]
        
        recipeDetail = RecipeDetail(title: recipeEntity?.title ?? "", imageData: recipeEntity?.imageData, ingredients: recipeEntity?.ingredients ?? [], url: recipeEntity?.url ?? "", yield: String(recipeEntity?.yield ?? "0") , totalTime: String(recipeEntity?.totalTime ?? "0"))
        
        performSegue(withIdentifier: "segueToDetailFavoriteViewController", sender: self)
    }
    
}
