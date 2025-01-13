# 🎬 Project Name: Movie Explorer App

## 📽️ About the App:
The Movie Explorer App is a responsive and user-friendly application that allows users to explore a wide range of movies. It features a home screen for browsing movies, a search functionality for filtering by title, and detailed movie information on a separate screen. The app is designed with state management and robust error handling, ensuring smooth operation across devices.

## 📸 Screenshots:
<div style="display: flex; flex-wrap: wrap; gap: 10px;">
    <img src="https://github.com/andreeayyad23/Movie_Explorer_App/blob/master/assets/Screenshot%202024-12-27%20140439.png?raw=true" alt="Screenshot 1" style="height: 200px; width: auto;">
    <img src="https://github.com/andreeayyad23/Movie_Explorer_App/blob/master/assets/Screenshot%202024-12-27%20135409.png?raw=true" alt="Screenshot 2" style="height: 200px; width: auto;">
    <img src="https://github.com/andreeayyad23/Movie_Explorer_App/blob/master/assets/Screenshot%202024-12-27%20135540.png?raw=true" alt="Screenshot 3" style="height: 200px; width: auto;">
    <img src="https://github.com/andreeayyad23/Movie_Explorer_App/blob/master/assets/Screenshot%202024-12-27%20135701.png?raw=true" alt="Screenshot 4" style="height: 200px; width: auto;">
    <img src="https://github.com/andreeayyad23/Movie_Explorer_App/blob/master/assets/MovieExplorer2.png?raw=true" alt="Movie Explorer 1" style="height: 200px; width: auto;">
    <img src="https://github.com/andreeayyad23/Movie_Explorer_App/blob/master/assets/MovieExplorer6.png?raw=true" alt="Movie Explorer 2" style="height: 200px; width: auto;">
    <img src="assets/Screenshot 2025-01-13 160935.png?raw=true" alt="Movie Explorer 2" style="height: 200px; width: auto;">
    <img src="assets/Screenshot 2025-01-13 161010.png?raw=true" alt="Movie Explorer 2" style="height: 200px; width: auto;">
</div>

### 🛠️ Built With:
1. [![Flutter](https://img.shields.io/badge/Flutter-v3.7.0-blue?logo=flutter)](https://flutter.dev/)
2. [![Dart](https://img.shields.io/badge/Dart-v2.19.0-blue?logo=dart)](https://dart.dev/)
3. [![TMDb API](https://img.shields.io/badge/TMDB-API-blue?logo=movie)](https://www.themoviedb.org/)

### 🎨 Colors Palette:
1. White
2. Black

###🌟 Features of the Movie Explorer App:

1. 🖼️ Splash Screen:
Added a visually engaging splash screen to create a captivating first impression, featuring seamless transitions and branding elements for an enhanced user experience.

2. 🏠 Home Screen:
Features a dynamic layout showcasing Upcoming Movies, Now Playing, and Top Rated sections, complemented by a convenient Search icon for easy navigation and movie discovery.

3. 🎬 Top Rated Section:
Displays a curated list of movies with their titles, images, and ratings, offering users quick access to the most popular and highly rated films.

4. 📱 Movie Browsing:
Users can browse movies seamlessly on the mobile app, with a clean and intuitive interface.

5. 🔍 Search Functionality:
Users can enter the title of the movie they are looking for, and they will see real-time updates as they type. An 'X' button is available to reset the search results.

6. ⏳ Loading Indicator:
A loading indicator is displayed while data is being fetched, with a 'No results found' message when the search yields no matches.

7. 🚫 Error Handling:
If the requested movie is not available in the API or if there is an error, the user will be redirected to a 'Not Found' page. Clicking this page will redirect them back to the home screen.

8.📡 API Integration:
The app fetches movie information via API integration, ensuring up-to-date and accurate data.

9. 📖 Detailed Movie Information:
Users can view detailed information about each movie, including the image, title, overview, rating, and release date. They can easily return to the home screen when finished browsing.

10. 💻 Perfect UI:
The app adapts beautifully to different devices, providing an intuitive and visually appealing interface that works seamlessly on both mobile and tablet screens.

11. ❤️ Favorite Feature:
Users can add movies to their favorites and remove them with a simple click. The favorite movies are saved locally using Provider as the state management tool.

12. 🛠️ State Management with Provider:
The app uses Provider as the state management tool to efficiently manage and share data across different screens, ensuring a smooth and responsive user experience.

13. 🌟 Favorite Screen:
Users can view all their favorited movies in one place. The Favorite Screen displays the movie posters, titles, and ratings, allowing users to easily access their favorite movies.


## 🚀 Setup Instructions

### 📋 Prerequisites
- **Flutter SDK**: Install from [Flutter's official site](https://flutter.dev/docs/get-started/install).
- **Android Studio** or **Visual Studio Code**: Set up your preferred development environment.
- **Android Emulator** or **iOS Simulator**: Alternatively, connect a physical device.

### 🛠️ Steps to Set Up the Project

1. **Clone the Repository**
   ```bash
   git clone https://github.com/andreeayyad23/movie_explorer_app.git
   cd movie_explorer_app

   
2. **Install Dependencies Needed**
   ```bash
    flutter pub get

3. **Run App**
   ```bash
    flutter run



