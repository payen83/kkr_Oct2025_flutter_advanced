import 'package:flutter/material.dart';
import 'package:flutter_advanced_2025/app/constant/color.constant.dart';
import 'package:flutter_advanced_2025/app/model/product.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({
    super.key, 
    required this.currentCategory, 
    required this.onCategoryTap
  });
    
  final Category currentCategory;
  final ValueChanged<Category> onCategoryTap;
  final List<Category> _categories = Category.values;

  Widget _buildCategory(Category category, BuildContext context){
    final categoryString = category.toString().replaceAll('Category.','').toUpperCase();
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: ()=> onCategoryTap(category),
      child: category == currentCategory 
      ? Column(children: [
        const SizedBox(height: 16,), 
        Text(categoryString, style: theme.textTheme.bodyLarge,textAlign: TextAlign.center,),
        const SizedBox(height: 14,),
        Container(
          width: 70,height: 2, color: kShrinePink400,
        )
      ],)
      
      :Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(categoryString, style: theme.textTheme.bodyLarge!.copyWith(color: kShrineBrown900),textAlign: TextAlign.center,),
      ),
    );
  }  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 40),
        color: kShrinePink100,
        child: ListView(
          children: _categories.map(
            (Category c)=> _buildCategory(c, context)
          ).toList()
        ),
      ),
    );
  }
}