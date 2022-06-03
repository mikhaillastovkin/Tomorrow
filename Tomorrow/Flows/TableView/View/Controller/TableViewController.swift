//
//  TableViewController.swift
//  Tomorrow
//
//  Created by Михаил Ластовкин on 17.03.2022.
//

import UIKit

class TableViewController: UIViewController, InputTableView {

    //MARK: - Properties
    lazy private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.returnKeyType = .default
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.placeholder = "Поиск"
        return searchBar
    }()

    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()

    lazy private var swipeGestureRecognizer: UISwipeGestureRecognizer = {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeGestureRecognizer.numberOfTouchesRequired = 1
        swipeGestureRecognizer.direction = .right
        return swipeGestureRecognizer
    }()

    var presenter: OutputTableView

    //MARK: - Life cicle
    init(presenter: OutputTableView) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        presenter.loadArticles(filter: presenter.category)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
        presenter.loadArticles(filter: presenter.category)
        tableView.reloadData()
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    //MARK: - UI
    private func configureUI() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)
        setupConstraints()
    }

    //MARK: Constraints
    private func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            searchBar.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0),
            searchBar.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0)
        ])
    }

    //MARK: Setup properties
    private func setupTableView() {
        self.tableView.addGestureRecognizer(swipeGestureRecognizer)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellIdentifire)
    }

    private func setupSearchBar() {
        self.searchBar.delegate = self
    }

    @objc private func swipe() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - TableView DataSourde

extension TableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.searchResult?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellIdentifire, for: indexPath) as? TableViewCell
        else { return UITableViewCell() }

        let article = presenter.searchResult?[indexPath.row]
        let title = article?.title
        let subtitle = article?.subtitle

        cell.configure(image: article?.imgName, title: title, subtitle: subtitle, indexPath: indexPath)

        return cell
    }
}

//MARK: - TableView Delegate

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (view.frame.height / 10)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.viewDidSelectArticle(index: indexPath.row)
    }
}

//MARK: - SearchBar Delegate

extension TableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.viewDidSeach(with: searchText)
        self.tableView.reloadData()
    }
}
