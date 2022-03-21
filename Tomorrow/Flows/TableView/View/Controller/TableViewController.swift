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
        return tableView
    }()

    var presenter: OutputTableView

    //MARK: - Life circle

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
        configureUI()
    }

    //MARK: - UI

    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)
        setupConstraints()
    }

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

    //MARK: - Private

    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellIdentifire)
    }

    private func setupSearchBar() {
        self.searchBar.delegate = self
    }

    private func addTableViewTapGestureRecognizers() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tableView.addGestureRecognizer(tapGR)
    }

    @objc func hideKeyboard() {
        guard let tapGR = tableView.gestureRecognizers?.last as? UITapGestureRecognizer
        else { return }
        tableView.removeGestureRecognizer(tapGR)
        searchBar.resignFirstResponder()
    }
}

//MARK: - TableView DataSourde

extension TableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.searchResult.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellIdentifire, for: indexPath) as? TableViewCell
        else { return UITableViewCell() }

        let article = presenter.searchResult[indexPath.row]
        let image = UIImage(named: article.imageName)
        let title = article.title
        let subtitle = article.subtitle

        cell.configure(image: image, title: title, subtitle: subtitle)

        return cell
    }
}

//MARK: - TableView Delegate

extension TableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.viewDidSelectArticle(index: indexPath.row)
    }
}

//MARK: - SearchBar Delegate

extension TableViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        addTableViewTapGestureRecognizers()
        return true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.viewDidSeach(with: searchText)
        self.tableView.reloadData()
    }
}
