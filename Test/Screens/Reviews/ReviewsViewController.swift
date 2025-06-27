import UIKit

final class ReviewsViewController: UIViewController {

    private lazy var reviewsView = makeReviewsView()
    private let viewModel: ReviewsViewModel
    private var count: Int

    init(viewModel: ReviewsViewModel) {
        self.viewModel = viewModel
        self.count = 0
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = reviewsView
        title = "Отзывы"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        viewModel.getReviews()
    }
}

// MARK: - Private

private extension ReviewsViewController {

    func makeReviewsView() -> ReviewsView {
        let reviewsView = ReviewsView()
        reviewsView.tableView.delegate = viewModel
        reviewsView.tableView.dataSource = viewModel

        let footer = makeReviewsNumberView(count: count)
        footer.frame.size.width = reviewsView.bounds.width

        reviewsView.tableView.tableFooterView = footer
        return reviewsView
    }

    func makeReviewsNumberView(count: Int) -> UIView {
        let container = UIView()
        container.frame.size.height = 44

        let label = UILabel()
        label.text = "\(count) \(pluralForm(for: count))"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: container.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(lessThanOrEqualTo: container.trailingAnchor, constant: -16)
        ])

        return container
    }

    func pluralForm(for count: Int) -> String {
        let remainder = count % 10
        let remainder100 = count % 100

        if remainder == 1 && remainder100 != 11 {
            return "отзыв"
        } else if (2...4).contains(remainder) && !(12...14).contains(remainder100) {
            return "отзыва"
        } else {
            return "отзывов"
        }
    }

    func setupViewModel() {
        viewModel.onStateChange = { [weak self] _ in
            guard let self = self else { return }

            self.count = self.viewModel.getReviewsNumber()

            let newFooter = self.makeReviewsNumberView(count: self.count)
            newFooter.frame.size.width = self.reviewsView.bounds.width
            self.reviewsView.tableView.tableFooterView = newFooter

            self.reviewsView.tableView.reloadData()
        }
    }
}
