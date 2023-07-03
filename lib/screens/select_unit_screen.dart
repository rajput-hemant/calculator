import 'package:flutter/material.dart';

import '../models/models.dart';

class SelectUnitScreen extends StatefulWidget {
  const SelectUnitScreen({
    super.key,
    required this.list,
    required this.selectedUnitIndex,
    this.isCurrency,
  });

  final List<Unit> list;
  final int selectedUnitIndex;
  final bool? isCurrency;

  @override
  State createState() => _SelectUnitScreenState();
}

class _SelectUnitScreenState extends State<SelectUnitScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<Unit> _filteredList = widget.list;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _filteredList = widget.list;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterList(String query) {
    setState(() {
      _filteredList = widget.list.where((unit) {
        final id = unit.id.toLowerCase();
        final name = unit.name.toLowerCase();
        final searchQuery = query.toLowerCase();

        return name.contains(searchQuery) || id.contains(searchQuery);
      }).toList();
    });
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _filterList('');
      }
    });
  }

  void _handleListTilePress(int index) {
    final originalIndex = widget.list.indexOf(_filteredList[index]);
    Navigator.pop(context, originalIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                onChanged: _filterList,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.white),
              )
            : Text(
                "Select ${widget.isCurrency == true ? "Currency" : "Unit"}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: ListView(
        children: [
          for (var index = 0; index < _filteredList.length; index++)
            RadioListTile(
              value: index,
              groupValue:
                  _filteredList.indexOf(widget.list[widget.selectedUnitIndex]),
              onChanged: (value) {
                _handleListTilePress(value!);
              },
              title: Text(
                "${widget.isCurrency == true ? "${_filteredList[index].flag} " : ""}${_filteredList[index].name} (${_filteredList[index].id})",
              ),
              controlAffinity: ListTileControlAffinity.trailing,
            ),
        ],
      ),
    );
  }
}
