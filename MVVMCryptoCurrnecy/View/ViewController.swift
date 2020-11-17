//
//  ViewController.swift
//  MVVMCryptoCurrnecy
//
//  Created by mac on 16.11.2020.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    

    @IBOutlet weak var tableView: UITableView!
    
    private var cryptoListViewModel : CryptoListViewModel!
    
    var colorArray = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        self.colorArray = [UIColor(red: 100/255, green: 150/255, blue: 170/255, alpha: 1.0)
        ,UIColor(red: 75/255, green: 150/255, blue: 170/255, alpha: 1.0)
        ,UIColor(red: 15/255, green: 200/255, blue: 100/255, alpha: 1.0)
        ,UIColor(red: 104/255, green: 220/255, blue: 60/255, alpha: 1.0)
        ,UIColor(red: 184/255, green: 10/255, blue: 50/255, alpha: 1.0)
        ,UIColor(red: 220/255, green: 50/255, blue: 30/255, alpha: 1.0)]
    
        getData()
    }
    
    func getData() {
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
    
        WebService().downloadCurrencies(url: url) { (cryptos) in
            if let cryptos = cryptos {
                self.cryptoListViewModel = CryptoListViewModel(cryptoCurrencyList: cryptos)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cryptoListViewModel == nil ? 0 : self.cryptoListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as! CryptoTableViewCell
        let cryptoViewModel = self.cryptoListViewModel.cryptoAtIndex(indexPath.row)
        cell.priceText.text = cryptoViewModel.price
        cell.currencyText.text = cryptoViewModel.name
        cell.backgroundColor = self.colorArray[indexPath.row % 6]
        return cell
    }
}

