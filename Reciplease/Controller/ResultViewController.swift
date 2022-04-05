//
//  ResultViewController.swift
//  Reciplease
//
//  Created by Aurelien Waxin on 28/01/2022.
//

import UIKit

final class ResultViewController: UIViewController {
    
    //    MARK: - Properties
    
    var recipeResponse: EdamamResponse?
    var recipeEntity: RecipeEntity?
    var recipeDetail : RecipeDetail?
    
    var ingredientList = [String]()
//    var isLoading = false
//    var number = 1
//    var rowNumber = 3
//    var recipeQuantity : Int!
//    var recipe = [Recipe]() {
//            didSet {
//                DispatchQueue.main.async { [weak self] in
//                    self?.recipeTableView.reloadData()
//                }
//            }
//        }
    
    //    MARK: - Outlets
    @IBOutlet weak var recipeTableView: UITableView!
    
    
    //    MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        recipeTableView.register(nibName, forCellReuseIdentifier: "RecipeCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipeVC = segue.destination as? DetailViewController else { return }
        recipeVC.recipeDetail = recipeDetail
    }
}



// MARK: - UITABLEVIEW DATA SOURCE
extension ResultViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeResponse?.hits?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let recipeCell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
                as? RecipeTableViewCell else { return UITableViewCell() }
        
        recipeCell.setRecipe = recipeResponse?.hits?[indexPath.row]
        
        return recipeCell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("BLANC C BLANC")
//        EdamamService.loadMoreData(.shared)(from: 20, to: 40, completionHandler: (Result<EdamamResponse, APIError>))
        
//        EdamamService.shared.getRecipe(ingredientsList: ingredientList.joined(separator: "+")) { result in
//            DispatchQueue.main.async {
//                switch result {
//                    case .success(let response) :
//                        self.recipeResponse = response
////                        self.performSegue(withIdentifier: "segueToResultViewController", sender: nil)
//                        print(response)
//                    case .failure(let error) :
//                        if error == .decodeError {
//                            self.presentRecipeAlert()
//                        } else {
//                            self.presentAlert()
//                            print(error)
//                        }
//
//                }
//            }
//        }
    }
}
//         let lastElement = (recipeResponse?.hits?.count)! - 1
//        let total = recipeResponse?.from ?? 12
//         if indexPath.row == lastElement && (recipeResponse?.hits?.count)! < total{
//
//            recipeResponse.loadmore(completionHandler: {finish in
//                if finish {
//
//                    self.tableView.reloadData()
//
//                }})
//        }
//    }

//            if indexPath.section == 0 {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeTableViewCell
////                cell.itemLabel.text = itemsArray[indexPath.row]
//                cell.setRecipe = recipeResponse?.hits[indexPath.row]
//                return cell
//            } else {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeTableViewCell
////                cell.activityIndicator.startAnimating()
//                return cell
//            }
//        }

//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//            let offsetY = scrollView.contentOffset.y
//            let contentHeight = scrollView.contentSize.height
//
//            if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
//                loadMoreData()
//            }
//        }

//    func loadMoreData() {
//        print("COUCOU")
//            if !self.isLoading {
//                self.isLoading = true
//                DispatchQueue.global().async {
//                    // Fake background loading task for 2 seconds
//                    sleep(2)
//                    // Download more data here
//                    DispatchQueue.main.async {
////                        self.recipeResponse?.from
////                        self.recipeResponse?.to
//                        self.recipeTableView.reloadData()
//                        self.isLoading = false
//                    }
//                }
//            }
//        }
//        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//            let lastSectionIndex = recipeTableView.numberOfSections - 1
//            let lastRowIndex = recipeTableView.numberOfRows(inSection: lastSectionIndex) - 1
//            if indexPath.section == lastSectionIndex && indexPath.row ==  lastRowIndex {
//
////            loadByDemand()
////                loadMoreData()
//                print("COUCOUTOI")
//            }
//                if indexPath.row == lastIndex {
//
//                    self.recipeTableView.reloadData()
//                    // api call and get next page
//
//                }
//            }
//}
//    private func fetchData(completed: ((Bool) -> Void)? = nil) {
//            EdamamService.shared.getRecipe(ingredientsList: ingredientList) { [weak self] result in
//                switch result {
//                case .success(let response):
//                    // 5
//                    self?.recipe.append(contentsOf: response)
//                    // assign last id for next fetch
////                    self?.currentLastId = recipe.last?.id
//                    completed?(true)
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    // 6
//                    completed?(false)
//                }
//            }
//        }


// MARK: - UITABLEVIEW DELEGATE
extension ResultViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = recipeResponse?.hits?[indexPath.row].recipe
        
        ////         a renvoyer au controller suivant 
        
        recipeDetail = RecipeDetail(title: detail?.label ?? "", imageData: detail?.image?.data, ingredients: detail?.ingredientLines ?? [], url: detail?.url ?? "", yield: String(detail?.yield ?? 0) , totalTime: String(detail?.totalTime ?? 0))
        
        recipeEntity?.ingredients = recipeDetail?.ingredients
        recipeEntity?.imageData = recipeDetail?.imageData
        recipeEntity?.url = recipeDetail?.url
        recipeEntity?.title = recipeDetail?.title
        recipeEntity?.totalTime = recipeDetail?.totalTime
        recipeEntity?.yield = recipeDetail?.yield
        
        performSegue(withIdentifier: "segueToDetailViewController", sender: self)
    }
}
