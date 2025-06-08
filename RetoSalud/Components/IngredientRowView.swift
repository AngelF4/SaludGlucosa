// MARK: - Ingredient Row

struct IngredientRowView: View {
    @Binding var ingredient: Ingredient

    var body: some View {
        HStack {
            Button {
                ingredient.isSelected.toggle()
            } label: {
                Image(systemName: ingredient.isSelected ? "checkmark.square" : "square")
                    .font(.title3)
            }
            Text(ingredient.name)
            Spacer()
            Text(ingredient.portion)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}