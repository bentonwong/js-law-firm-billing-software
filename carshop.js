var cars = [
  {
    brand: 'honda',
    model: 'civic',
    properties: {
      color: "green",
      clean: false
    }
  },
  {
    brand: 'toyota',
    model: 'prius',
    properties: {
      color: "silver",
      clean: true
    }
  },
  {
    brand: 'ford',
    model: 'mustang',
    properties: {
      color: "blue",
      clean: false
    }
  },
  {
    brand: 'chevy',
    model: 'camaro',
    properties: {
      color: "red",
      clean: false
    }
  },
]

function cleanCars(cars) {
  for (let i = 0; i < cars.length; i++) {
    if (!cars[i].properties.clean) {
      cars[i].properties.clean = true
    }
  }
}

function paintCarsWithColor(color, newColor) {
  for (let i = 0; i < cars.length; i++) {
    if (cars[i].properties.color === color) {
      cars[i].properties.color = newColor
    }
  }
}

cleanCars(cars)
paintCarsWithColor('green', 'blue')
paintCarsWithColor('blue', 'purple')
console.log(cars)
