import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import '../widgets/search_form.dart';
import '../utils/data_helper.dart';
import '../widgets/favorite_button.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/fishing_spot.dart';
import 'special_page.dart';

class SearchPage extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteItems;

  const SearchPage({
    super.key,
    required this.favoriteItems,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final List<bool> _selectedPrices = List.generate(20, (index) => false);
  List<FishingSpot> _data = [];
  List<FishingSpot> _filteredData = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _loadJsonData();
    if (kDebugMode) {
      debugPrint('SearchPage: initState is called');
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _loadJsonData() async {
    try {
      final List<FishingSpot> data =
          await loadJsonData('assets/data/wakayama_data.json');
      setState(() {
        _data = data;
        _filteredData = _data;
      });
    } catch (e) {
      debugPrint('❌ Error loading JSON data: $e');
    }
  }

  void _filterData() {
    setState(() {
      final nameQuery = _nameController.text.trim().toLowerCase();
      final locationQuery = _locationController.text.trim().toLowerCase();
      final selectedPrices = _selectedPrices;

      _filteredData = _data.where((spot) {
        final nameMatch = nameQuery.isEmpty || spot.name.toLowerCase().contains(nameQuery);
        final locationMatch = locationQuery.isEmpty || spot.location.toLowerCase().contains(locationQuery);
        final priceMatch = !selectedPrices.contains(true) ||
            selectedPrices[spot.price ~/ 1000];

        return nameMatch && locationMatch && priceMatch;
      }).toList();
    });
  }

  void _onConditionChanged() {
    if (kDebugMode) {
      debugPrint('_onConditionChanged called');
    }
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), _filterData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('条件検索'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchForm(
                nameController: _nameController,
                locationController: _locationController,
                onConditionChanged: _onConditionChanged,
              ),
              const SizedBox(height: 16),
              const Text('料金範囲', style: TextStyle(fontSize: 18)),
              _buildPriceRangeFilters(),
              const SizedBox(height: 16),
              const Text('検索結果', style: TextStyle(fontSize: 18)),
              _buildSearchResults(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRangeFilters() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: 16,
        itemBuilder: (context, index) {
          final title = index < 15
              ? '${index * 1000} ~ ${(index + 1) * 1000} 円'
              : '15000 円以上';
          return CheckboxListTile(
            title: Text(title),
            value: _selectedPrices[index],
            onChanged: (bool? value) {
              setState(() {
                _selectedPrices[index] = value ?? false;
              });
              _onConditionChanged();
            },
          );
        },
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_filteredData.isEmpty) {
      return const Center(
        child: Text(
          '一致する条件がありません',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _filteredData.length,
      itemBuilder: (context, index) {
        final item = _filteredData[index];
        final bool hasWebsite = item.link.isNotEmpty;

        return GestureDetector(
          onTap: () async {
            if (hasWebsite) {
              final Uri url = Uri.parse(item.link);
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              }
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SpecialPage(
                    name: item.name,
                    price: '${item.price}円',
                    location: item.location,
                    phoneNumber: '未設定', // 仮の電話番号
                  ),
                ),
              );
            }
          },
          child: Card(
            color: hasWebsite ? Colors.blue : Colors.grey.shade300,
            child: ListTile(
              title: Text(
                item.name,
                style: const TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                hasWebsite ? '公式HPあり' : '公式HPなし',
                style: TextStyle(
                  color: hasWebsite ? Colors.black54 : Colors.black54,
                ),
              ),
              trailing: FavoriteButton(
                favoriteKey: item.id,
                initialIsFavorite: widget.favoriteItems.any(
                  (fav) => fav['id'] == item.id,
                ),
                onFavoriteUpdated: () async {
                  _updateFavoriteStatus(item);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _updateFavoriteStatus(FishingSpot item) async {
    setState(() {
      final isAlreadyFavorite =
          widget.favoriteItems.any((fav) => fav['id'] == item.id);

      if (isAlreadyFavorite) {
        widget.favoriteItems.removeWhere((fav) => fav['id'] == item.id);
      } else {
        widget.favoriteItems.add({
          'id': item.id,
          'name': item.name,
          'link': item.link,
        });
      }
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('favorite_list', jsonEncode(widget.favoriteItems));
    debugPrint('✅ Favorites saved to SharedPreferences');
  }
}

