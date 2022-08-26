class Categories{
  String? category,subcategory;

  Categories(this.category, this.subcategory);

  Categories.fromJson(Map<String,dynamic>json){
    category=json['category'];
    subcategory=json['subcategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['subcategory'] = subcategory;
    return data;
  }
}
class Locations {
  Locations({this.location, this.sublocation, this.children = const <Locations>[]});

  final List<String>? location;
  final List<String>? sublocation;
  final List<Locations>? children;
}

final List<Locations> data = <Locations>[
  Locations(
    location: ['Turkey'],
    sublocation: ['asof','sdjglskf'],
    children: <Locations>[
      Locations(
        location: ['İstanbul'],
        sublocation: [
          'Pendik',
          'Kartal',
          'Kadıköy',
          'Tuzla',
          'Eminönü',
          'Fatih',
          'Beşiktaş',
          'Maltepe',
          'Bağcılar',
          'asfdsa',
          'gadssd',
          'sdgsdg',
          'sdgsfhğapsfr',
          'SDAŞLKFAĞSÜPKGFAS',
          'Kızılay',
          'Ulus',
          'Esat',
          'Manhanttan',
          'Bronx',
          'Queens',
          'Los Angeles',
          'San Diego',
          'San Jose',
        ],
      ),
      Locations(
        location: ['Ankara'],
        sublocation: [
          'Kızılay',
          'Ulus',
          'Esat',
        ],
      ),
    ],
  ),
  Locations(
    location: ['USA'],
    children: <Locations>[
      Locations(
        location: ['New York'],
        sublocation: [
          'Manhanttan',
          'Bronx',
          'Queens',
        ],
      ),
      Locations(
        location: ['California'],
        sublocation: [
          'Los Angeles',
          'San Diego',
          'San Jose',
        ],
      ),
    ],
  ),
];
