import 'dart:io';
import 'dart:math';
import 'package:abdelrahman/components/primary_button.dart';
import 'package:abdelrahman/control/auth_provider.dart';
import 'package:abdelrahman/control/products_notifier.dart';
import 'package:abdelrahman/model/Product.dart';
import 'package:abdelrahman/model/dbHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';
import '../../../theme.dart';

class AddProductForm extends StatefulWidget {
  @override
  _AddProductFormFormState createState() => _AddProductFormFormState();
}

class _AddProductFormFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  DbHelper _dbHelper = DbHelper();
  TextEditingController? title,
      price,
      priceBefore,
      image,
      stock,
      description,
      category,
      ratting;
  File? file;
  Product? product;

  Future<void> photo(imageSource) async {
    final _picker = ImagePicker();
    var image = await _picker.pickImage(source: imageSource);
    setState(() {
      file = File(image!.path);
    });
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error!);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dbHelper = DbHelper();
    product = Product();
    title = TextEditingController();
    price = TextEditingController();
    priceBefore = TextEditingController(text: '0.00');
    stock = TextEditingController();
    ratting = TextEditingController();
    description = TextEditingController();
    image = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () async {
                  photo(ImageSource.gallery);
                },
                color: kPrimaryColor,
                icon: Icon(
                  Icons.add_photo_alternate_outlined,
                  size: 40,
                ),
              ),
              IconButton(
                onPressed: () async {
                  photo(ImageSource.camera);
                },
                color: kPrimaryColor,
                icon: Icon(
                  Icons.add_a_photo_outlined,
                  size: 40,
                ),
              ),
            ],
          ),
          SizedBox(height: getScreenHeight(30)),
          file == null
              ? SizedBox()
              : Container(
                  height: 200,
                  width: SizeConfig.screenWidth,
                  child: Image.file(
                    file!,
                    fit: BoxFit.fill,
                  ),
                ),
          SizedBox(height: getScreenHeight(30)),
          buildFormField('Enter Name Product', 'Title', 'Enter Name Product',
              Icon(Icons.title), title),
          SizedBox(height: getScreenHeight(30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: getScreenWidth(150),
                child: buildPriceFormField(),
              ),
              SizedBox(width: getScreenHeight(10)),
              Container(
                width: getScreenWidth(150),
                child: buildPriceBeforeFormField(),
              ),
            ],
          ),
          SizedBox(height: getScreenHeight(30)),
          buildFormField('Enter stock ', 'product stock ', 'product stock',
              Icon(Icons.add_to_photos_outlined), stock),
          SizedBox(height: getScreenHeight(30)),
          buildFormField(
              'Enter description',
              'description',
              'Enter description ',
              Icon(Icons.description_outlined),
              description),
          SizedBox(height: getScreenHeight(30)),
          SizedBox(height: getScreenHeight(40)),
          Consumer(builder: (context, watch, _) {
            return PrimaryButton(
              title: "Add Product ",
              onPressed: () async {
                if (file == null) {
                  scaffoldMessenger('Add Image');
                  return;
                }

                if (_formKey.currentState!.validate()) {
                  scaffoldMessenger('Waiting .......');

                  product = Product(
                    id: Random.secure().nextInt(1000000),
                    isPopular: 0,
                    isFavourite: 0,
                    rating: int.parse(stock!.text),
                    title: title!.text,
                    price: double.parse(price!.text),
                    description: description!.text,
                    image: file!.path,
                    type: 'normal',
                    priceBefore: double.parse(priceBefore!.text),
                  );
                  print(product!.isFavourite);
                  await _dbHelper
                      .createDateItem(product!);
                  scaffoldMessenger(' The Product is Added ');

                  stock !.clear();
                  title!.clear();
                  stock !.clear();
                  price!.clear();
                  priceBefore!.clear();
                  image!.clear();
                  description!.clear();
                }
              },
            );
          }),
        ],
      ),
    );
  }

  scaffoldMessenger(message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      message,
      textDirection: TextDirection.rtl,
    )));
  }

  TextFormField buildFormField(error, label, hint, Icon, output) {
    return TextFormField(
      keyboardType: hint.toString() == 'product stock'
          ? TextInputType.number
          : TextInputType.text,
      controller: output,
      onSaved: (newValue) => output = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: error);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: error);
          return "";
        }
        return null;
      },
      maxLines: label == 'description' ? 5 : 1,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        suffixIcon: Icon,
      ),
    );
  }

  TextFormField buildTitleFormField() {
    return TextFormField(
      onSaved: (newValue) => title!.text = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: 'Enter Title ');
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: 'Enter Title ');
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Title",
        hintText: "Enter your Tile",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPriceFormField() {
    return TextFormField(
      controller: price,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => price!.text = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: 'Enter Price');
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: 'Enter Price');
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(getScreenWidth(5)),
            gapPadding: 0.2),

        labelText: "Price",
        hintText: "\$00.00",
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.attach_money),
      ),
    );
  }

  TextFormField buildPriceBeforeFormField() {
    return TextFormField(
      controller: priceBefore,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => priceBefore!.text = newValue!,
      onChanged: (value) {},
      validator: (value) {},
      decoration: InputDecoration(
        labelText: " Price Before",
        hintText: "\$00.00",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.money_off_csred_outlined),
      ),
    );
  }

  PopupMenuItem<String> myPopupMenuItem(String value) {
    return PopupMenuItem<String>(
      value: value,
      child: ListTile(
        //  leading: Icon(icons, size: 25, color: Colors.green),
        title: Text(value.toUpperCase(),
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
