//
//  ResultViewController.swift
//  Reciplease
//
//  Created by Aurelien Waxin on 28/01/2022.
//

import UIKit
import Foundation

final class ResultViewController: UIViewController {
    
    var recipeResponse: EdamamResponse?
    var recipeData: RecipeData?
    
    @IBOutlet weak var recipeTableView: UITableView!
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        recipeTableView.register(nibName, forCellReuseIdentifier: "RecipeCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipeVC = segue.destination as? DetailViewController else { return }
        recipeVC.recipeData = recipeData
    }
}
    


// MARK: - UITABLEVIEW DATA SOURCE
extension ResultViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeResponse?.hits.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let recipeCell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
                as? RecipeTableViewCell else { return UITableViewCell() }
        
        recipeCell.setRecipe = recipeResponse?.hits[indexPath.row]

        return recipeCell
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let lastIndex = recipeResponse?.hits.count
//            if indexPath.row == lastIndex {
//                
//                self.recipeTableView.reloadData()
//                // api call and get next page
//            }
//        }
}


// MARK: - UITABLEVIEW DELEGATE
extension ResultViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = recipeResponse?.hits[indexPath.row].recipe
////         a renvoyer au controller suivant 
//        
        recipeData = RecipeData(title: detail?.label ?? "", imageData: detail?.image?.data, ingredients: detail?.ingredientLines ?? [], url: detail?.url ?? "", yield: String(detail?.yield ?? 0) , totalTime: String(detail?.totalTime ?? 0))
        
        performSegue(withIdentifier: "segueToDetailViewController", sender: self)
    }
}
