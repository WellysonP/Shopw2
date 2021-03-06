import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/models/product.dart';
import 'package:shop2/models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocurs = FocusNode();
  final _descriptionFocus = FocusNode();

  final _urlFocus = FocusNode();
  final _urlControler = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  bool _isloading = false;

  @override
  void initState() {
    super.initState();
    _urlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;
        _formData["id"] = product.id;
        _formData["name"] = product.name;
        _formData["price"] = product.price;
        _formData["description"] = product.description;
        _formData["imageUrl"] = product.imageUrl;

        _urlControler.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocurs.dispose();
    _descriptionFocus.dispose();
    _urlFocus.removeListener(updateImage);
    _urlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endWithFile = url.toLowerCase().endsWith(".png") ||
        url.toLowerCase().endsWith(".jpg") ||
        url.toLowerCase().endsWith(".jpeg");
    return isValidUrl && endWithFile;
  }

  Future<void> _submitForm() async {
    final isValidate = _formKey.currentState?.validate() ?? false;

    if (!isValidate) {
      return;
    }
    _formKey.currentState?.save();

    setState(() => _isloading = true);

    try {
      await Provider.of<ProductList>(context, listen: false)
          .saveProduct(_formData);
      Navigator.of(context).pop();
    } catch (erro) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("ERRO"),
          content: Text("Ocorreu um erro ao salvar o produto."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Reportar"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Sair"),
            )
          ],
        ),
      );
    } finally {
      setState(() => _isloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: Icon(Icons.save),
          )
        ],
        title: Text("Formul??rio de Produto"),
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData["name"]?.toString(),
                      decoration: InputDecoration(labelText: "Nome"),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        Focus.of(context).requestFocus(_priceFocurs);
                      },
                      onSaved: (name) => _formData["name"] = name ?? "",
                      validator: (_name) {
                        final name = _name ?? "";

                        if (name.trim().isEmpty) {
                          return "Nome ?? obrigat??rio";
                        }
                        if (name.trim().length < 3) {
                          return "M??nimo de 3 letras";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData["price"]?.toString(),
                      decoration: InputDecoration(labelText: "Pre??o"),
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocurs,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionFocus);
                      },
                      onSaved: (price) =>
                          _formData["price"] = double.parse(price ?? "0"),
                      validator: (_price) {
                        final priceString = _price ?? "";
                        final price = double.tryParse(priceString) ?? 0;

                        if (price == 0) {
                          return "Pre??o ?? obrigat??rio";
                        }

                        if (price < 0) {
                          return "Pre??o invalido";
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData["description"]?.toString(),
                      decoration: InputDecoration(labelText: "Descri????o"),
                      focusNode: _descriptionFocus,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      onSaved: (description) =>
                          _formData["description"] = description ?? "",
                      validator: (_description) {
                        final description = _description ?? "";

                        if (description.trim().isEmpty) {
                          return "Descri????o ?? obrigat??ria";
                        }
                        if (description.trim().length < 10) {
                          return "M??nimo de 10 letras";
                        }
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: "Url da Imagem"),
                            focusNode: _urlFocus,
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _urlControler,
                            onFieldSubmitted: (_) => _submitForm(),
                            onSaved: (imageUrl) =>
                                _formData["imageUrl"] = imageUrl ?? "",
                            validator: (_imageUrl) {
                              final imageUrl = _imageUrl ?? "";

                              if (imageUrl.isEmpty) {
                                return "Url ?? obrigat??rio";
                              }

                              if (!isValidImageUrl(imageUrl.toString())) {
                                return "Necess??rio arquivo PNG, JPG ou JPEG";
                              }

                              return null;
                            },
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: _urlControler.text.isEmpty
                              ? Text("Informe a Url")
                              : Image.network(_urlControler.text),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
