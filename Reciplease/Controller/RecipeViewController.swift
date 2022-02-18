//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Aurelien Waxin on 28/01/2022.
//

import UIKit

class RecipeViewController: UIViewController {
    
    var ingredientList = [String]()
    let edamamService = EdamamService()
    var recipeResponse : EdamamResponse?
    
    
    
    @IBOutlet private var ingredientSearchTableView: UITableView!
    @IBOutlet private var ingredientTextField: UITextField!
    @IBOutlet private var searchButton: UIButton!
    
    @IBAction func dismissedKeyboard(_ sender: UITapGestureRecognizer) {
        ingredientTextField.resignFirstResponder()
    }
    
    override func viewDidLoad(){
//        self.tableView.register(UITableViewCell.self, forCellWithReuseIdentifier: "cell")
        super.viewDidLoad()
    }
    
    @IBAction func clearIngredientsButton(_ sender: UIButton) {
        self.ingredientList = [String]()
        ingredientList.removeAll()
        ingredientSearchTableView.reloadData()
    }
    
    @IBAction func addIngredientButton(_ sender: UIButton) {
        guard let ingredientToAdd = ingredientTextField.text else {return}
        if ingredientToAdd != "" {
            ingredientList.append(ingredientToAdd)
            print(ingredientList)
            self.ingredientTextField.text = ""
            ingredientSearchTableView.reloadData()
        }
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        makeAPICall()
        print(ingredientList)
    }
    
    private func makeAPICall() {
        if ingredientList.isEmpty {
            presentAlert()
        } else {
            edamamService.getRecipe(ingredientsList: ingredientList.joined(separator: ",")) { result in
                switch result {
                    case .success(let response) :
                        self.recipeResponse = response
                        self.performSegue(withIdentifier: "segueToResultViewController", sender: nil)
                        print(response)
                    case .failure(let error) :
                        self.presentAlert()
                        print(error)
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let recipesList = segue.destination as? ResultViewController else { return }
        recipesList.recipeResponse = recipeResponse!
        }
}

// MARK:  - UITABLEVIEW DATA SOURCE

extension RecipeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientListCell", for: indexPath)
        cell.textLabel?.text = "- " + ingredientList[indexPath.row]
        cell.textLabel?.font = UIFont (name:"Chalkduster",size: 21)
        return cell
    }
}
//Delete style func
extension RecipeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            ingredientList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
