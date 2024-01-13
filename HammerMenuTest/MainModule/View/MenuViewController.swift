//
//  SceneDelegate.swift
//  HammerMenuTest
//
//  Created by Tim Akhmetov on 12.01.2024.
//

import UIKit

class MenuViewController: UIViewController {
    
    var presenter: MainViewPresenterProtocol!
    
    private let cityButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Москва ⋁", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableHeaderView: BannersView = {
        let width = UIScreen.main.bounds.size.width
        let height = width * 0.35
        let bannerView = BannersView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        return bannerView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        setConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.9293106794, green: 0.929469943, blue: 0.9293007255, alpha: 1)
        
        view.addSubview(cityButton)
        view.addSubview(tableView)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = tableHeaderView
        tableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            cityButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cityButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cityButton.widthAnchor.constraint(equalToConstant: 100),
            
            tableView.topAnchor.constraint(equalTo: cityButton.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - UITableViewDelegate

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.mainCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MenuTableViewCell else { return UITableViewCell() }
        
        let model = presenter.mainCellViewModels[indexPath.row]
        cell.setupCell(model: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        172
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = CategoriesView()
        view.delegate = self
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}

// MARK: - ScrollToCategoryViewDelegate

extension MenuViewController: ScrollToCategoryViewDelegate {
    func scrollToRow(with index: IndexPath) {
        tableView.scrollToRow(at: index, at: .middle, animated: true)
    }
}

// MARK: - Presenter

extension MenuViewController: MainView {
    
    func finishLoading() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
