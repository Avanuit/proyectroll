import '../models/user_model.dart';
import '../models/post_model.dart';
import '../models/story_model.dart';
import '../models/comment_model.dart';


final User currentUser = User(
  id: '1',
  username: 'tu_usuario',
  name: 'Tu Nombre',
  imageUrl: 'https://picsum.photos/200',
  bio: 'Desarrollador Flutter 👨‍💻 | Amante del café ☕',
  followers: 1245,
  following: 567,
  posts: 42,
);

final List<User> users = [
  User(
    id: '2',
    username: 'sofia_m',
    name: 'Sofía Martínez',
    imageUrl: 'https://picsum.photos/201',
    bio: 'Fotógrafa profesional 📸',
    followers: 8765,
    following: 234,
    posts: 128,
    isVerified: true,
  ),
  User(
    id: '3',
    username: 'carlos_a',
    name: 'Carlos Andrade',
    imageUrl: 'https://picsum.photos/202',
    bio: 'Viajero ✈️ | Aventurero 🏔️',
    followers: 3456,
    following: 789,
    posts: 56,
  ),
  User(
    id: '4',
    username: 'laura_v',
    name: 'Laura Vargas',
    imageUrl: 'https://picsum.photos/203',
    bio: 'Diseñadora UX/UI 🎨',
    followers: 9876,
    following: 345,
    posts: 87,
    isVerified: true,
  ),
  User(
    id: '5',
    username: 'javier_r',
    name: 'Javier Rojas',
    imageUrl: 'https://picsum.photos/204',
    bio: 'Chef 👨‍🍳 | Food lover 🍕',
    followers: 5432,
    following: 678,
    posts: 65,
  ),
];


final List<Story> stories = [
  Story(
    id: '1',
    user: users[0], // sofia_m - ÍNDICE VÁLIDO
    imageUrl: 'https://picsum.photos/200?random=1',
  ),
  Story(
    id: '2',
    user: users[1], // carlos_a - ÍNDICE VÁLIDO
    imageUrl: 'https://picsum.photos/200?random=2',
  ),
  Story(
    id: '3',
    user: users[2], // laura_v - ÍNDICE VÁLIDO
    imageUrl: 'https://picsum.photos/200?random=3',
  ),
  Story(
    id: '4',
    user: users[3], // javier_r - ÍNDICE VÁLIDO
    imageUrl: 'https://picsum.photos/200?random=4',
  ),
  Story(
    id: '5',
    user: users[0], // sofia_m (repetido) - ÍNDICE VÁLIDO
    imageUrl: 'https://picsum.photos/200?random=5',
  ),
  Story(
    id: '6',
    user: users[1], // carlos_a (repetido) - ÍNDICE VÁLIDO
    imageUrl: 'https://picsum.photos/200?random=6',
  ),
];

final List<Post> posts = [
  Post(
    id: '1',
    user: users[0], // sofia_m - ÍNDICE VÁLIDO
    imageUrl: 'https://picsum.photos/400',
    caption: 'Hermoso día en la playa! ☀️ #verano #playa #vacaciones',
    likes: 120,
    comments: 15,
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  Post(
    id: '2',
    user: users[1], // carlos_a - ÍNDICE VÁLIDO
    imageUrl: 'https://picsum.photos/401',
    caption: 'Nueva aventura comienza! 🏔️ #viaje #aventura #naturaleza',
    likes: 89,
    comments: 8,
    timestamp: DateTime.now().subtract(const Duration(hours: 5)),
  ),
  Post(
    id: '3',
    user: users[2], // laura_v - ÍNDICE VÁLIDO
    imageUrl: 'https://picsum.photos/402',
    caption: 'Diseñando la nueva interfaz para nuestra app. ¿Qué opinan? 🎨 #diseño #ux #ui',
    likes: 245,
    comments: 32,
    timestamp: DateTime.now().subtract(const Duration(hours: 8)),
    isLiked: true,
  ),
  Post(
    id: '4',
    user: users[3], // javier_r - ÍNDICE VÁLIDO
    imageUrl: 'https://picsum.photos/403',
    caption: 'Nuevo plato en el menú! 🍝 #comida #chef #gourmet',
    likes: 367,
    comments: 45,
    timestamp: DateTime.now().subtract(const Duration(hours: 12)),
    isSaved: true,
  ),
];

final List<Comment> comments = [
  Comment(
    id: '1',
    user: users[1], // carlos_a - ÍNDICE VÁLIDO
    text: '¡Qué foto tan increíble! 😍',
    timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    likes: 12,
  ),
  Comment(
    id: '2',
    user: users[2], // laura_v - ÍNDICE VÁLIDO
    text: 'Me encanta este lugar! ❤️',
    timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
    likes: 8,
  ),
  Comment(
    id: '3',
    user: users[3], // javier_r - ÍNDICE VÁLIDO
    text: '¿Qué cámara usaste para esta foto?',
    timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    likes: 3,
  ),
];