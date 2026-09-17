# Shopping App

A Flutter-based product catalog application developed as part of a Junior Mobile Developer technical assessment.

The application integrates with the DummyJSON REST API to retrieve and display products. Users can browse products, load additional products through pagination, search for products, and view detailed product information including images and customer reviews.

---

## Features

### 1. Product Listing
The main screen displays products in a grid-based layout. Each product card provides key information including:
* Product thumbnail
* Product title and Brand
* Category
* Original price and Discounted price (calculated dynamically)
* Rating and Discount percentage
* Shipping information

### 2. Pagination
The product listing supports progressive loading using the `skip` parameter provided by the DummyJSON API.
The application initially requests:
`GET /products?limit=20&skip=0`

As the user scrolls towards the end of the product list, additional products are requested (e.g., `skip=20`, `skip=40`). New products are seamlessly appended to the existing product list instead of replacing previously loaded products, reducing the initial data load and allowing for smooth progressive browsing.

### 3. Product Details
Users can tap a product card to open its detail screen. The detail screen retrieves the selected product using its product ID and displays:
* Multiple product images (swipeable image view)
* Comprehensive description
* Price, Rating, and Discount
* Shipping information
* Customer reviews (parsed via a dedicated `Review` model rather than plain text)

### 4. Product Search & Debouncing
The application provides a search field utilizing the DummyJSON search endpoint:
`GET /products/search?q={query}`

Search requests are strictly debounced to prevent API spam for every individual keystroke. When the user types a query, the application waits for a 500ms pause before firing the request. This performs a server-side search against the entire API dataset rather than just filtering locally cached items.

### 5. Application States
* **Loading State:** Visual feedback (spinners) is provided during initial loads, pagination, searches, and detail retrieval.
* **Empty State:** If a search yields zero results, the app displays a clear empty-state message rather than a confusing blank grid.
* **Error State:** API request failures trigger a clear error message with a retry mechanism, preventing silent app failures. Image loading errors display a fallback placeholder.

---

## Error Prevention

* **Empty Search:** Search results are validated before painting the UI. If no products match, a placeholder replaces the grid.
* **Network Connectivity:** A network connectivity listener was implemented to detect hardware-level connectivity changes. *Note: This listener is currently disabled in the submitted version because connectivity detection behaved inconsistently within the Android emulator environment.* API request failures are still safely caught and handled by the application's standard HTTP error handling.

---

## Code Architecture

* **Models:** Converts API JSON responses into strongly typed Dart objects (Product, Review).
* **Services:** Isolates HTTP and JSON-processing logic from the UI. ProductService handles fetching, pagination, searching, and detail retrieval.
* **Views:** Manages screen-level state, scroll controllers, and user interactions.
* **Widgets:** Contains reusable UI components (like ProductCard) to keep the main screens clean and modular.

---

## API Integration

The application consumes the DummyJSON API:
* **Product List:** `GET https://dummyjson.com/products?limit=20&skip=0`
* **Product Search:** `GET https://dummyjson.com/products/search?q={query}`
* **Product Details:** `GET https://dummyjson.com/products/{id}`

---

## Future Improvements / TODOs

The following improvements were identified during architectural planning but were scoped out of this current assessment build:

* **Product Presentation:** Normalize discount percentage displays to rounded integers (e.g., `-10%`) via conditional logic,
* **Implement `cached_network_image` to prevent redownloading assets during heavy scrolling.
* **API and Network Handling:** Inject strict timeout durations for all API requests to prevent infinite loading
* **Pull-to-refresh:** Improve graceful recovery for API/server connection interruptions.
* **Search and Discovery:** Enhance the empty-search behavior by fetching and displaying a randomized selection of products instead of a static placeholder.
* **Category Navigation:** Implement category-based browsing, allowing users to filter the grid by specific product categories.
* **Shopping Functionality:** Implement local state management for an "Add to Cart" feature and a dedicated checkout screen.
* **Testing:** Implement automated unit tests for model JSON parsing and API service methods.

---

## AI Assistance

AI tools (ChatGPT/Gemini) were utilized as a supplementary development resource for Flutter implementation guidance, syntax debugging, and API architecture clarification. The final application architecture, feature scoping, project structure, and codebase were implemented by the author. This readme also have been generated by AI.

---

## Technology Stack

* **Framework:** Flutter
* **Language:** Dart
* **Network:** HTTP (REST API)
* **Backend:** DummyJSON
* **Typography:** Google Fonts

---

## Getting Started

### Requirements
* Flutter SDK & Dart SDK
* Android Studio / VS Code
* Android Emulator or physical device
* Active internet connection

### Installation

Clone the repository:
```bash
git clone [https://github.com/Hedgie06/shopping_app1.git](https://github.com/Hedgie06/shopping_app1.git)
cd shopping_app1
