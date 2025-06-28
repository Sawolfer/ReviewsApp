import UIKit

final class ReviewsView: UIView {

    let tableView = UITableView()
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = bounds.inset(by: safeAreaInsets)
    }

    deinit {
        tableView.delegate = nil
        tableView.dataSource = nil
    }
}

// MARK: - Loading indicator

extension ReviewsView {
    private func setupLoadingIndicator() {
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loadingIndicator)

        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func setLoading(_ isLoading: Bool) {
        if isLoading {
            loadingIndicator.startAnimating()
            tableView.isHidden = true
        } else {
            loadingIndicator.stopAnimating()
            tableView.isHidden = false
        }
    }
}

// MARK: - Private

private extension ReviewsView {

    func setupView() {
        backgroundColor = .systemBackground
        setupTableView()
        setupLoadingIndicator()
    }

    func setupTableView() {
        addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(ReviewCell.self, forCellReuseIdentifier: ReviewCellConfig.reuseId)

        let footer = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 44))
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.center = CGPoint(x: footer.bounds.midX, y: footer.bounds.midY)
        indicator.tag = 1001
        footer.addSubview(indicator)
        tableView.tableFooterView = footer
    }

    func setFooterLoading(_ isLoading: Bool) {
        guard let footer = tableView.tableFooterView,
              let indicator = footer.viewWithTag(1001) as? UIActivityIndicatorView else {
            return
        }

        if isLoading {
            indicator.startAnimating()
        } else {
            indicator.stopAnimating()
        }
    }
}
