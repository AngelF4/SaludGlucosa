
struct Ingredient: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let portion: String
    var isSelected: Bool = true
}