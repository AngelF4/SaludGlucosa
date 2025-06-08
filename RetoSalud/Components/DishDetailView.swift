
struct DishDetailView: View {
    @State private var dish: Dish

    init(dish: Dish) {
        _dish = State(initialValue: dish)
    }

    var body: some View {
        ScrollView {
            Image(dish.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .cornerRadius(12)
                .padding()

            VStack(alignment: .leading, spacing: 16) {
                Text(dish.name)
                    .font(.title2)
                    .bold()

                Text("\(dish.calories) calorías")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Divider()

                Text("Cómo afectaría al índice glucémico")
                    .font(.headline)

                ForEach(dish.glycemicEffects, id: \.self) { effect in
                    HStack(alignment: .top) {
                        Text("•")
                        Text(effect)
                    }
                }

                Button(action: {
                    let included = dish.ingredients.filter(\.isSelected)
                    print("Ingredientes incluidos: \(included)")
                }) {
                    Text("+ Añadir alimento")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.pink.opacity(0.2))
                        .cornerRadius(8)
                }

                Divider()

                Text("Ingredientes")
                    .font(.headline)

                ForEach($dish.ingredients) { $ingredient in
                    IngredientRowView(ingredient: $ingredient)
                }
            }
            .padding(.horizontal)
        }
    }
}