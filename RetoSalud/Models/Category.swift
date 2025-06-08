
struct Category: Identifiable {
    let id = UUID()
    let name: String
    let dishes: [Dish]
}