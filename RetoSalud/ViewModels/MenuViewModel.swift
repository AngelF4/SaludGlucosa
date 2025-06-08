class MenuViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var selectedDish: Dish?

    init() {
        loadSampleData()
    }

    private func loadSampleData() {
        categories = [
            // Fibras
            Category(name: "Fibras", dishes: [
                Dish(
                    name: "Avena con nueces",
                    imageName: "avena_nueces",
                    calories: 200,
                    description: "Avena cocida con nueces y miel.",
                    glycemicEffects: ["27g Carbohidratos netos 🌾", "Incremento de 12–18 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Avena", portion: "50g"),
                        Ingredient(name: "Nueces", portion: "20g"),
                        Ingredient(name: "Miel", portion: "10g")
                    ]
                ),
                Dish(
                    name: "Pan integral tostado",
                    imageName: "pan_integral",
                    calories: 150,
                    description: "Rebanada de pan integral con aguacate.",
                    glycemicEffects: ["20g Carbohidratos netos 🍞", "Incremento de 15–20 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Pan integral", portion: "1 rebanada"),
                        Ingredient(name: "Aguacate", portion: "50g")
                    ]
                ),
                Dish(
                    name: "Ensalada de espinacas",
                    imageName: "ensalada_espinacas",
                    calories: 120,
                    description: "Espinacas frescas con tomate cherry.",
                    glycemicEffects: ["8g Carbohidratos netos 🥗", "Incremento de 5–10 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Espinacas", portion: "100g"),
                        Ingredient(name: "Tomate cherry", portion: "50g")
                    ]
                ),
                Dish(
                    name: "Barra de granola",
                    imageName: "barra_granola",
                    calories: 180,
                    description: "Barra casera de granola y frutos secos.",
                    glycemicEffects: ["22g Carbohidratos netos 🌰", "Incremento de 14–19 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Granola", portion: "30g"),
                        Ingredient(name: "Frutos secos", portion: "20g")
                    ]
                ),
                Dish(
                    name: "Smoothie verde",
                    imageName: "smoothie_verde",
                    calories: 160,
                    description: "Bebida de espinaca, manzana y pepino.",
                    glycemicEffects: ["18g Carbohidratos netos 🥤", "Incremento de 10–15 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Espinaca", portion: "50g"),
                        Ingredient(name: "Manzana", portion: "1/2 unidad"),
                        Ingredient(name: "Pepino", portion: "50g")
                    ]
                )
            ]),
            // Carbohidratos
            Category(name: "Carbohidratos", dishes: [
                Dish(
                    name: "Tacos al pastor",
                    imageName: "tacos_pastor",
                    calories: 250,
                    description: "Tacos de cerdo con piña.",
                    glycemicEffects: ["15g Carbohidratos netos 🌮","Incremento de 10–18 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Tortilla", portion: "2 unidades"),
                        Ingredient(name: "Carne al pastor", portion: "100g"),
                        Ingredient(name: "Piña", portion: "30g")
                    ]
                ),
                Dish(
                    name: "Pasta integral",
                    imageName: "pasta_integral",
                    calories: 300,
                    description: "Pasta de trigo integral con salsa de tomate.",
                    glycemicEffects: ["40g Carbohidratos netos 🍝","Incremento de 20–30 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Pasta integral", portion: "100g"),
                        Ingredient(name: "Salsa de tomate", portion: "50g")
                    ]
                ),
                Dish(
                    name: "Arroz con verduras",
                    imageName: "arroz_verduras",
                    calories: 280,
                    description: "Arroz blanco con zanahoria y chícharos.",
                    glycemicEffects: ["45g Carbohidratos netos 🍚","Incremento de 22–28 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Arroz", portion: "100g"),
                        Ingredient(name: "Zanahoria", portion: "50g"),
                        Ingredient(name: "Chícharos", portion: "50g")
                    ]
                ),
                Dish(
                    name: "Pan pita",
                    imageName: "pan_pita",
                    calories: 160,
                    description: "Pan pita integral con hummus.",
                    glycemicEffects: ["25g Carbohidratos netos 🥙","Incremento de 15–20 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Pan pita", portion: "1 unidad"),
                        Ingredient(name: "Hummus", portion: "30g")
                    ]
                ),
                Dish(
                    name: "Sandwich de pollo",
                    imageName: "sandwich_pollo",
                    calories: 320,
                    description: "Sandwich con pechuga de pollo y pan integral.",
                    glycemicEffects: ["35g Carbohidratos netos 🥪","Incremento de 18–24 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Pan integral", portion: "2 rebanadas"),
                        Ingredient(name: "Pechuga de pollo", portion: "80g"),
                        Ingredient(name: "Lechuga", portion: "20g")
                    ]
                )
            ]),
            // Proteína
            Category(name: "Proteína", dishes: [
                Dish(
                    name: "Salmón al horno",
                    imageName: "salmon_horno",
                    calories: 300,
                    description: "Filete de salmón con hierbas.",
                    glycemicEffects: ["0g Carbohidratos netos 🐟","Sin efecto significativo"],
                    ingredients: [
                        Ingredient(name: "Salmón", portion: "150g"),
                        Ingredient(name: "Hierbas", portion: "5g")
                    ]
                ),
                Dish(
                    name: "Pechuga de pollo",
                    imageName: "pechuga_pollo",
                    calories: 220,
                    description: "Pechuga asada con especias.",
                    glycemicEffects: ["0g Carbohidratos netos 🍗","Sin efecto significativo"],
                    ingredients: [
                        Ingredient(name: "Pechuga de pollo", portion: "120g"),
                        Ingredient(name: "Especias", portion: "al gusto")
                    ]
                ),
                Dish(
                    name: "Huevos revueltos",
                    imageName: "huevos_revueltos",
                    calories: 180,
                    description: "Huevos con espinaca y cebolla.",
                    glycemicEffects: ["1g Carbohidratos netos 🥚","Sin efecto significativo"],
                    ingredients: [
                        Ingredient(name: "Huevos", portion: "2 unidades"),
                        Ingredient(name: "Espinaca", portion: "30g"),
                        Ingredient(name: "Cebolla", portion: "20g")
                    ]
                ),
                Dish(
                    name: "Bistec a la plancha",
                    imageName: "bistec_plancha",
                    calories: 350,
                    description: "Bistec de res sin grasa visible.",
                    glycemicEffects: ["0g Carbohidratos netos 🥩","Sin efecto significativo"],
                    ingredients: [
                        Ingredient(name: "Bistec", portion: "150g"),
                        Ingredient(name: "Sal y pimienta", portion: "al gusto")
                    ]
                ),
                Dish(
                    name: "Tofu salteado",
                    imageName: "tofu_salteado",
                    calories: 200,
                    description: "Tofu con verduras salteadas.",
                    glycemicEffects: ["3g Carbohidratos netos 🥢","Sin efecto significativo"],
                    ingredients: [
                        Ingredient(name: "Tofu", portion: "100g"),
                        Ingredient(name: "Verduras mixtas", portion: "50g")
                    ]
                )
            ]),
            // Vitaminas
            Category(name: "Vitaminas", dishes: [
                Dish(
                    name: "Smoothie de frutas",
                    imageName: "smoothie_frutas",
                    calories: 180,
                    description: "Fresas, plátano y yogurt.",
                    glycemicEffects: ["28g Carbohidratos netos 🍓","Incremento de 20–25 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Fresas", portion: "100g"),
                        Ingredient(name: "Plátano", portion: "1 unidad"),
                        Ingredient(name: "Yogurt", portion: "120ml")
                    ]
                ),
                Dish(
                    name: "Ensalada de quinoa",
                    imageName: "ensalada_quinoa",
                    calories: 220,
                    description: "Quinoa y vegetales frescos.",
                    glycemicEffects: ["19g Carbohidratos netos 🥗","Incremento de 12–16 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Quinoa", portion: "100g"),
                        Ingredient(name: "Pepino", portion: "50g"),
                        Ingredient(name: "Tomate cherry", portion: "50g")
                    ]
                ),
                Dish(
                    name: "Fruta fresca",
                    imageName: "fruta_fresca",
                    calories: 90,
                    description: "Manzana, naranja y pera.",
                    glycemicEffects: ["20g Carbohidratos netos 🍎","Incremento de 15–20 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Manzana", portion: "1 unidad"),
                        Ingredient(name: "Naranja", portion: "1/2 unidad"),
                        Ingredient(name: "Pera", portion: "1/2 unidad")
                    ]
                ),
                Dish(
                    name: "Yogurt griego",
                    imageName: "yogurt_griego",
                    calories: 130,
                    description: "Yogurt con frutos rojos.",
                    glycemicEffects: ["7g Carbohidratos netos 🥣","Incremento de 5–8 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Yogurt griego", portion: "150g"),
                        Ingredient(name: "Frutos rojos", portion: "30g")
                    ]
                ),
                Dish(
                    name: "Zumo de naranja",
                    imageName: "zumo_naranja",
                    calories: 100,
                    description: "Zumo natural exprimido.",
                    glycemicEffects: ["22g Carbohidratos netos 🍊","Incremento de 18–22 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Naranja", portion: "2 unidades")
                    ]
                )
            ]),
            // Grasas
            Category(name: "Grasas", dishes: [
                Dish(
                    name: "Aguacate relleno",
                    imageName: "aguacate_relleno",
                    calories: 250,
                    description: "Mitad de aguacate con atún.",
                    glycemicEffects: ["2g Carbohidratos netos 🥑","Sin efecto significativo"],
                    ingredients: [
                        Ingredient(name: "Aguacate", portion: "1/2 unidad"),
                        Ingredient(name: "Atún", portion: "50g")
                    ]
                ),
                Dish(
                    name: "Nueces mixtas",
                    imageName: "nueces_mixtas",
                    calories: 180,
                    description: "Mezcla de nueces y almendras.",
                    glycemicEffects: ["5g Carbohidratos netos 🌰","Sin efecto significativo"],
                    ingredients: [
                        Ingredient(name: "Nueces", portion: "30g"),
                        Ingredient(name: "Almendras", portion: "20g")
                    ]
                ),
                Dish(
                    name: "Aceitunas mediterráneas",
                    imageName: "aceitunas",
                    calories: 120,
                    description: "Aceitunas verdes y negras.",
                    glycemicEffects: ["1g Carbohidratos netos 🫒","Sin efecto significativo"],
                    ingredients: [
                        Ingredient(name: "Aceitunas", portion: "50g")
                    ]
                ),
                Dish(
                    name: "Chips de kale",
                    imageName: "chips_kale",
                    calories: 90,
                    description: "Hojas de kale horneadas.",
                    glycemicEffects: ["3g Carbohidratos netos 🥬","Incremento mínimo"],
                    ingredients: [
                        Ingredient(name: "Kale", portion: "30g")
                    ]
                ),
                Dish(
                    name: "Ensalada con aceite",
                    imageName: "ensalada_oliva",
                    calories: 140,
                    description: "Vegetales frescos con aceite de oliva.",
                    glycemicEffects: ["4g Carbohidratos netos 🥗","Sin efecto significativo"],
                    ingredients: [
                        Ingredient(name: "Vegetales mixtos", portion: "100g"),
                        Ingredient(name: "Aceite de oliva", portion: "10ml")
                    ]
                )
            ])
        ]
    }
}