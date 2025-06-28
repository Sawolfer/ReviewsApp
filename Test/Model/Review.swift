/// Модель отзыва.
struct Review: Decodable {
    /// Имя пользователя
    var first_name: String
    /// Фамилия пользователя
    var last_name: String
    /// рейтинг отзыва
    let rating: Int
    /// Текст отзыва.
    let text: String
    /// Время создания отзыва.
    let created: String
    /// Картинки к отзыву
    let images: [String]?

    let avatar_url: String
}


