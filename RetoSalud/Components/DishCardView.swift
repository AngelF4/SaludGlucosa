struct DishCardView: View {
    let dish: Dish

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(dish.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 250, height: 150)
                .clipped()
                .cornerRadius(12)

            VStack(alignment: .leading, spacing: 4) {
                Text(dish.name)
                    .font(.headline)
                    .foregroundColor(.white)
                Text("\(dish.calories) calorías")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .padding(8)
            .background(Color.black.opacity(0.4))
            .cornerRadius(8)
            .padding(8)
        }
    }
}