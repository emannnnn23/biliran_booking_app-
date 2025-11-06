// lib/data/mock_data.dart
// -------------------------------------------------------
// MOCK DATA for Client Home Feed
// -------------------------------------------------------
// This file simulates service providers and their packages.
// You can later replace this with data from your Django API.
// -------------------------------------------------------

import '../models/service_provider_model.dart';
import '../models/service_model_package.dart';


final mockProviders = [
  ServiceProvider(
    id: 'prov1',
    name: 'Maria’s Catering',
    category: 'Catering Services',
    profileImage: 'assets/images/StockCake.com-Band Stage Lights.jpg',
    location: 'Naval',
    rating: 4.8,
    totalReviews: 120,
  ),
  ServiceProvider(
    id: 'prov2',
    name: 'Almeria Events Place',
    category: 'Event Venue',
    profileImage: 'assets/images/foods.jpg',
    location: 'Almeria',
    rating: 4.6,
    totalReviews: 85,
  ),
  ServiceProvider(
    id: 'prov3',
    name: 'Light & Sound Pro',
    category: 'Sound System',
    profileImage: 'assets/images/catering.jpg',
    location: 'Caibiran',
    rating: 4.9,
    totalReviews: 47,
  ),
];

final mockPackages = [
  ServicePackage(
    id: 'pkg1',
    title: 'Full Wedding Catering Package',
    description: 'Includes buffet setup for 100 pax, servers, and table décor.',
    price: 25000,
    images: ['assets/images/StockCake.com-Band Stage Lights.jpg'],
    provider: mockProviders[0],
    datePosted: DateTime.now().subtract(const Duration(days: 1)),
  ),
  ServicePackage(
    id: 'pkg2',
    title: 'Birthday Venue + Lights Package',
    description:
        'Indoor hall with lighting setup and background music system.',
    price: 18000,
    images: ['assets/images/foods.jpg'],
    provider: mockProviders[1],
    datePosted: DateTime.now().subtract(const Duration(days: 3)),
  ),
  ServicePackage(
    id: 'pkg3',
    title: 'Concert Sound & Stage Setup',
    description:
        'Professional lighting and audio setup for up to 500 attendees.',
    price: 40000,
    images: ['assets/images/catering.jpg'],
    provider: mockProviders[2],
    datePosted: DateTime.now().subtract(const Duration(hours: 12)),
  ),
];
