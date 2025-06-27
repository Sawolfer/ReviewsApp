/// Модель, хранящая состояние вью модели.
struct ReviewsViewModelState {

    var items = [any TableCellConfig]()
    var count = 0
    var limit = 20
    var offset = 0
    var shouldLoad = true

}
