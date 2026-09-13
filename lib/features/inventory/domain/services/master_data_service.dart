import '../models/category.dart';
import '../models/brand.dart';
import '../models/unit.dart';
import '../models/tax_profile.dart';
import '../models/department.dart';

class MasterDataService {
  List<Department> getDepartments() => [
        const Department(id: 'dept_1', name: 'Grocery'),
        const Department(id: 'dept_2', name: 'Apparel'),
        const Department(id: 'dept_3', name: 'Household'),
        const Department(id: 'dept_4', name: 'Pharmacy'),
      ];

  List<Category> getCategories() => [
        const Category(id: 'cat_1', name: 'Electronics'),
        const Category(id: 'cat_2', name: 'Fashion & Apparel'),
        const Category(id: 'cat_3', name: 'Home & Kitchen'),
        const Category(id: 'cat_4', name: 'Health & Beauty'),
        const Category(id: 'cat_5', name: 'Men > T-Shirts > Round Neck'),
      ];

  List<Brand> getBrands() => [
        const Brand(id: 'br_1', name: 'ZENO Signature'),
        const Brand(id: 'br_2', name: 'Apple'),
        const Brand(id: 'br_3', name: 'Nike'),
        const Brand(id: 'br_4', name: 'Samsung'),
        const Brand(id: 'br_5', name: 'ZENO'),
      ];

  List<Unit> getUnits() => [
        const Unit(id: 'u_1', name: 'Piece', symbol: 'Pc'),
        const Unit(id: 'u_2', name: 'Kilogram', symbol: 'Kg'),
        const Unit(id: 'u_3', name: 'Box', symbol: 'Bx'),
        const Unit(id: 'u_4', name: 'Metre', symbol: 'M'),
        const Unit(id: 'u_5', name: 'Piece (Pc)', symbol: 'Pc'),
      ];

  List<TaxProfile> getTaxProfiles() => [
        const TaxProfile(id: 'tax_1', name: 'GST 5%', rate: 5.0),
        const TaxProfile(id: 'tax_2', name: 'GST 12%', rate: 12.0),
        const TaxProfile(id: 'tax_3', name: 'GST 18%', rate: 18.0),
        const TaxProfile(id: 'tax_4', name: 'Zero Tax', rate: 0.0),
      ];
}
