const List<String> retailCanonicalProfiles = [
  "Hypermarket",
  "Supermarket",
  "Grocery / Kirana",
  "Mini Market",
  "Fresh Produce",
  "Butchery & Meat",
  "Fish & Seafood",
  "Organic Store",
  "Liquor & Wine",
  "Tobacco Store",
  "Duty Free",
  "Convenience Store",
  "Department Store",
  "Dairy Booth",
];

const List<String> fnbCanonicalProfiles = [
  "Fine Dining",
  "Casual Dining",
  "Express QSR",
  "Cloud Delivery",
  "Bakery & Pastry",
  "Cafe / Barista",
  "Juice & Beverage",
  "Pizzeria",
  "Bar & Pub",
  "Ice Cream & Gelato",
  "Sweet Shop / Mithai",
  "Banquet & Catering",
  "Shisha Lounge",
];

const List<String> fashionCanonicalProfiles = [
  "Clothing",
  "Footwear",
  "Jewelry & Metals",
  "Watches",
  "Eyewear",
  "Cosmetics",
  "Perfume",
  "Boutique",
  "Bridal Wear",
  "Bags & Luggage",
  "Accessories",
  "Innerwear",
  "Kids Fashion",
  "Sportswear",
];

final Map<String, String> canonicalProfileAliases = {
  "Grocery": "Grocery / Kirana",
  "Kirana": "Grocery / Kirana",
  "Grocer / Kirana": "Grocery / Kirana",
  "Cafe": "Cafe / Barista",
  "Barista": "Cafe / Barista",
  "Bakery": "Bakery & Pastry",
  "Pastry": "Bakery & Pastry",
  "Coffee Shop": "Cafe / Barista",
  "Footwear / Shoes": "Footwear",
  "Shoes": "Footwear",
  "Watch Store": "Watches",
  "Eyewear / Opticals": "Eyewear",
  "Jewelry": "Jewelry & Metals",
  "Bags": "Bags & Luggage",
  "Departmental Store": "Department Store",
  "Liquor Store": "Liquor & Wine",
  "Tobacco Shop": "Tobacco Store",
  "Duty Free Shop": "Duty Free",
  "Fine Dining Restaurant": "Fine Dining",
  "Restaurant": "Casual Dining",
  "Fast Food": "Express QSR",
  "Cloud Kitchen": "Cloud Delivery",
  "Ice Cream Parlor": "Ice Cream & Gelato",
  "Sweet Shop": "Sweet Shop / Mithai",
  "Mithai": "Sweet Shop / Mithai",
  "Bar / Pub": "Bar & Pub",
  "Fashion": "Clothing",
};

String resolveCanonicalProfile(String profile, {String? fallback}) {
  final value = (profile ?? '').trim();
  if (value.isEmpty) return fallback ?? '';
  return canonicalProfileAliases[value] ?? value;
}

final Map<String, List<String>> businessCategoryMap = {
  "Retail": retailCanonicalProfiles,
  "Food & Beverage": fnbCanonicalProfiles,
  "Fashion": fashionCanonicalProfiles,
  "Healthcare": [
    "Medical Shop", "Clinic", "Pharmacy", "Diagnostics Center", "Hospital Supply",
    "Medical Equipment", "Ayurvedic Medicine", "Homeopathy Store", "Health Supplements",
    "Dental Clinic", "Optical Clinic"
  ],
  "Services": [
    "Salon", "Spa", "Laundry", "Repair Center", "Dry Cleaning", "Tailoring",
    "Printing Service", "Courier Service", "IT Services", "Consultancy",
    "Education / Coaching", "Gym / Fitness Center"
  ],
  "Wholesale": [
    "General Wholesale", "Food Wholesale", "Grocery Wholesale", "Garment Wholesale",
    "Footwear Wholesale", "Electronics Wholesale", "Hardware Wholesale",
    "Building Materials Wholesale", "Medical Wholesale", "Industrial Wholesale",
    "FMCG Wholesale", "Electrical Wholesale", "Textile Wholesale", "Plastic Products Wholesale"
  ],
  "Electronics": [
    "Mobile & Accessories", "Computers & Laptops", "TVs & Home Entertainment",
    "Audio", "Cameras", "Appliances", "Gaming", "Electronic Components",
    "Smart Home", "Accessories", "Office Electronics", "Networking Equipment",
    "Security Systems", "Wearables"
  ],
  "Furniture": [
    "Home Furniture", "Office Furniture", "Bedroom Furniture", "Living Room Furniture",
    "Dining Furniture", "Outdoor Furniture", "Modular Furniture", "Mattresses",
    "Furniture Accessories", "Antiques", "Kitchen Furniture", "Kids Furniture"
  ],
  "Hardware": [
    "Hand Tools", "Power Tools", "Electrical Hardware", "Plumbing",
    "Building Hardware", "Fasteners", "Paint & Supplies", "Safety Equipment",
    "Locks & Security", "Industrial Hardware", "Garden Tools", "Pneumatic Tools"
  ],
  "Automobile": [
    "Car Parts", "Motorcycle Parts", "Commercial Vehicle Parts", "Tyres & Wheels",
    "Batteries", "Lubricants", "Accessories", "Tools & Equipment", "Car Care",
    "Automobile Services", "Spare Parts", "Engine Components", "Brake Systems", "Suspension"
  ],
  "Agriculture": [
    "Seeds", "Fertilizers", "Pesticides", "Agricultural Tools", "Irrigation",
    "Farm Equipment", "Animal Feed", "Plant Nursery", "Gardening",
    "Agricultural Supplies", "Organic Farming", "Hydroponics", "Poultry Equipment"
  ],
  "Pet Shop": [
    "Dog", "Cat", "Birds", "Fish & Aquarium", "Small Animals", "Pet Food",
    "Pet Accessories", "Grooming", "Pet Healthcare", "Pet Supplies", "Reptiles", "Pet Toys"
  ],
  "Stationery": [
    "School Supplies", "Office Supplies", "Writing Instruments", "Paper Products",
    "Art & Craft", "Files & Folders", "Printing Supplies", "Desk Accessories",
    "Educational Supplies", "Gift Wrapping", "Drafting Tools"
  ],
  "Book Store": [
    "Fiction", "Non-Fiction", "Academic", "Children's Books", "Religious Books",
    "Reference", "Magazines & Journals", "Stationery & Book Accessories",
    "E-Books / Digital", "Comics", "Rare Books"
  ],
  "Toy Store": [
    "Educational Toys", "Action Figures", "Dolls", "Building & Construction",
    "Remote Control", "Board Games", "Outdoor Toys", "Baby Toys", "Puzzles",
    "Collectibles", "Arts & Crafts Toys", "Soft Toys"
  ],
  "Sports Store": [
    "Fitness", "Running", "Football", "Cricket", "Basketball", "Tennis",
    "Badminton", "Swimming", "Outdoor & Camping", "Sports Accessories",
    "Indoor Games", "Cycling", "Fishing"
  ],
  "Home Decor": [
    "Wall Decor", "Lighting & Lamps", "Curtains", "Rugs & Carpets", "Cushions",
    "Mirrors", "Decorative Accessories", "Vases & Planters", "Clocks",
    "Home Fragrance", "Wallpapers", "Bedding", "Table Decor"
  ],
  "General / Standard": ["General Product"]
};
